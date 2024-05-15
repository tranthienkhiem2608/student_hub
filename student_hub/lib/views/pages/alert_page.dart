import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/services/notification_services.dart';
import 'package:student_hub/services/socket_services.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/messages_viewModel.dart';
import 'package:student_hub/view_models/notification_viewModel.dart';
import 'package:student_hub/views/company_proposal/hire_student_screen.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:student_hub/models/model/notification.dart';
import '../../widgets/custom_notification/invited_notification.dart';
import '../../widgets/custom_notification/messages_notification.dart';
import '../../widgets/custom_notification/offer_notification.dart';
import '../../widgets/custom_notification/submitted_notification.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AlertPage extends StatefulWidget {
  const AlertPage(this.user, {super.key});
  final User? user;
  // final IO.Socket socket;

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  List<Notify> notifications = [];
  late IO.Socket socket;
  late Notify newNotify;
  late Timer? timer;

  @override
  void initState() {
    super.initState();
    connect();
    fetchNotify(widget.user!.id!).then((value) {
      if (mounted) {
        setState(() {
          notifications = value;
          //sort notification near on top to far
          notifications.sort((a, b) => b.createAt!.compareTo(a.createAt!));
        });
      }
    });

    print("SOCKET note: ${socket.connected}");
    print('User ID note: NOTI_${widget.user!.id}');
    socket.on('NOTI_${widget.user!.id}', (data) {
      print('New Notification: $data');
      if (mounted) {
        setState(() {
          newNotify = Notify.fromMapNotify(data['notification']);
          notifications.add(newNotify);
          notifications.sort((a, b) => b.createAt!.compareTo(a.createAt!));
        });

        LocalNotificationService.showNotification(data['notification']);
      }
    });
    timer = Timer.periodic(const Duration(seconds: 5), (timer) => connect());
  }

  void connect() {
    socket = SocketService().connectSocket();
    socket.connect();
  }

  @override
  void dispose() {
    timer?.cancel();
    socket.disconnect();
    super.dispose();
  }

  Future<List<Notify>> fetchNotify(int userId) async {
    List<Notify> messList = await NotifyViewModel().getAllNotifications(userId);
    return messList;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: notifications.length,
            itemBuilder: (BuildContext context, int index) {
              final notify = notifications[index];
              final now = DateTime.now();
              final createdAt = DateTime.parse(notify.createAt!);
              final previousCreatedAt = index > 0
                  ? DateTime.parse(notifications[index - 1].createAt!)
                  : null;

              

              return Column(
                children: <Widget>[
                  if (index == 0 ||
                      (index > 0 && previousCreatedAt!.day != createdAt.day))
                    
                  GestureDetector(
                    onTap: () async {
                      (notify.typeNotifyFlag == "1" ||
                              notify.typeNotifyFlag == "3")
                          ? () {
                              MessagesViewModel().setReadMess(notify.id!);
                              ControllerRoute(context).navigateToChatRoom(
                                  notify.receiver!.id!,
                                  notify.sender!.id!,
                                  notify.message!.projectId!,
                                  notify.receiver!.fullname!,
                                  notify.sender!.fullname!,
                                  widget.user!,
                                  1);
                            }()
                          : notify.typeNotifyFlag == "2"
                              ? () {
                                  MessagesViewModel().setReadMess(notify.id!);
                                  ControllerRoute(context).navigateToHomeScreen(
                                      false, widget.user!, 1);
                                }()
                              : null;
                      print('Type: ${notify.typeNotifyFlag}');
                    },
                    child: notify.typeNotifyFlag == "2"
                        ? SubmittedNotify(notify)
                        : notify.typeNotifyFlag == "3"
                            ? MessagesNotify(notify)
                            : notify.typeNotifyFlag == "1"
                                ? InvitedNotify(notify, widget.user!)
                                : notify.typeNotifyFlag == "0"
                                    ? OfferNotify(notify, widget.user!)
                                    : Container(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
