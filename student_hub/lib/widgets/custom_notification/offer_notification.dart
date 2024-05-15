import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/notification.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/messages_viewModel.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class OfferNotify extends StatefulWidget {
  Notify notify;
  User user;
  OfferNotify(this.notify, this.user, {Key? key}) : super(key: key);

  @override
  _OfferNotifyState createState() => _OfferNotifyState();
}

class _OfferNotifyState extends State<OfferNotify> {
  String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inSeconds <= 0) {
      return 'time0'.tr();
    } else if (diff.inSeconds < 60 && diff.inSeconds > 0) {
      return '${diff.inSeconds} ${'time1'.tr()}';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} ${'time2'.tr()}';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} ${'time3'.tr()}';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} ${'time4'.tr()}';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).round()} ${'time5'.tr()}';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).round()} ${'time6'.tr()}';
    } else {
      return '${(diff.inDays / 365).round()} ${'time4'.tr()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Container(
      color:
          widget.notify.notifyFlag == "0" ? Color.fromARGB(255, 171, 216, 255).withOpacity(0.2) : null,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 26.0), // Adjust the bottom padding to move the icon up
                  child: Icon(
                    Icons.work,
                    color:Color.fromARGB(255, 131, 255, 109),
                    size: 30,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${widget.notify.title}',
                        style: GoogleFonts.poppins(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        timeAgo(DateTime.parse(widget.notify.createAt!)),
                        style: GoogleFonts.poppins(
                            color: isDarkMode
                                ? Color.fromARGB(255, 213, 213, 213)
                                : Color.fromARGB(255, 72, 72, 72),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 150,
                        height: 40,
                        child: widget.notify.proposal!.statusFlag == 2
                            ? () {
                                print(widget.notify.proposal!.statusFlag);
                                return ElevatedButton(
                                  onPressed: () {
                                    // Handle send action here
                                    // Navigator.of(context).pop();
                                    MessagesViewModel()
                                        .setReadMess(widget.notify.id!);
                                    ControllerRoute(context)
                                        .navigateToOfferDetail(
                                            widget.notify, widget.user);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFF406AFF)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  child: Text("View offer",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white)),
                                );
                              }()
                            : widget.notify.proposal!.statusFlag == 3
                                ? () {
                                    print(widget.notify.proposal!.statusFlag);
                                    return Text(
                                      'Offer was accepted',
                                      style: GoogleFonts.poppins(
                                        color: const Color.fromARGB(
                                            255, 0, 255, 0),
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }()
                                : () {
                                    print(widget.notify.proposal!.statusFlag);
                                    return Text(
                                      'Offer was declined',
                                      style: GoogleFonts.poppins(
                                        color: const Color.fromARGB(
                                            255, 255, 38, 74),
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
