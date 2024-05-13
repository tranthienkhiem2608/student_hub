import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/notification.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/not_use/student_registered.dart';
import 'package:student_hub/view_models/notification_viewModel.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:student_hub/widgets/show_student_proposals_widget.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ScheduleInterviewPage extends StatefulWidget {
  final User? user;
  ScheduleInterviewPage({Key? key, this.user}) : super(key: key);

  @override
  _ScheduleInterviewPageState createState() => _ScheduleInterviewPageState();
}

class _ScheduleInterviewPageState extends State<ScheduleInterviewPage> {
  late Future<List<Notify>> futureNotify;
  List<Notify> notifyList = [];

  @override
  void initState() {
    super.initState();
    // companyId = widget.user!.companyUser!.id!;
    setState(() {
      // Update your state here
      futureNotify = fetchNotify(widget.user!.id!);
      futureNotify.then((value) {
        print(value);
        notifyList.addAll(value);
      });
    });
    //print projectList;
  }

  Future<List<Notify>> fetchNotify(int userId) async {
    List<Notify> messList = await NotifyViewModel().getAllNotifications(userId);
    return messList;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Visibility(
      replacement: Center(
        child: Text(
          "\t\tYou no have schedule interview",
          style: GoogleFonts.poppins(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      visible: notifyList.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Divider(),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Expanded(
            child: FutureBuilder<List<Notify>>(
              future: futureNotify,
              builder: (context, notify) {
                if (notify.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (notify.hasError) {
                  return Text('Error: ${notify.error}');
                } else {
                  return ListView.builder(
                    itemCount: notify.data!.length,
                    itemBuilder: (context, index) {
                      print(notify.data![index].id);
                      // print(proposal.data![index].coverLetter);
                      if (notify.data![index].typeNotifyFlag == 3) {
                        return GestureDetector(
                            // child: ShowStudentProposalsWidget(
                            //   proposal: proposal.data![index],
                            //   user: widget.user!,
                            // ),
                            );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }

  Future<List<Proposal>> fetchDataProposalStudent() async {
    // lấy dữ liệu từ server
    // if (widget.projectCompany != null && widget.projectCompany.id != null) {
    //   return await ProposalViewModel(context)
    //       .getProposalByProject(widget.projectCompany.id!);
    // }
    return [];
  }
}
