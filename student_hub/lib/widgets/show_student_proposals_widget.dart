import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/education.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/student_user.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ShowStudentProposalsWidget extends StatefulWidget {
  Proposal proposal;
  User user;

  ShowStudentProposalsWidget({
    required this.proposal,
    required this.user,
  });

  @override
  _ShowStudentProposalsWidgetState createState() =>
      _ShowStudentProposalsWidgetState();
}

class _ShowStudentProposalsWidgetState
    extends State<ShowStudentProposalsWidget> {
  bool isHireOfferSent = false;
  bool isSendMessage = false;
  late StudentUser studentRegistered;

  String getText() {
    final currentYear = DateTime.now().year;
    final educationList = widget.proposal.studentUser!.education;
    Education? closestEducation;

    for (var education in educationList!) {
      if (education.endYear != null && education.endYear! >= 0) {
        if (closestEducation == null || (currentYear <= education.endYear!)) {
          closestEducation = education;
        }
      }
    }

    if (closestEducation != null) {
      int timeYear = (closestEducation.endYear! - closestEducation.startYear!) -
          (closestEducation.endYear! - currentYear);
      switch (timeYear) {
        case 1:
          return 'hired_page1'.tr();
        case 2:
          return 'hired_page2'.tr();
        case 3:
          return 'hired_page3'.tr();
        case 0:
          return 'hired_page4'.tr();
        default:
          return '${'hired_page14'.tr()}${(closestEducation.endYear! - closestEducation.startYear!) - (closestEducation.endYear! - currentYear)}${'hired_page5'.tr()}';
      }
    } else {
      return 'hired_page6'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/user_img.png',
              width: 70,
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.proposal.studentUser!.user!, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF406AFF))
                  ),
                  Text(getText(), style: GoogleFonts.poppins(color: isDarkMode ? Colors.white : Colors.black)),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 5, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.proposal.studentUser!.techStack!.name, style: GoogleFonts.poppins(color: isDarkMode ? Colors.white : Colors.black)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.proposal.coverLetter!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(color: isDarkMode ? Colors.white : Colors.black)
            ),
          ),
        ),
        widget.proposal.statusFlag != 3
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 180,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        print(isSendMessage);
                        isSendMessage == false
                            ? setState(() {
                                isSendMessage = true;
                                widget.proposal.statusFlag = 1;
                                // ProposalViewModel(context)
                                //     .setStatusFlagProject(widget.proposal);
                                ControllerRoute(context).navigateToChatRoom(
                                    widget.user.id!,
                                    widget.proposal.studentUser!.userId!,
                                    widget.proposal.projectId!,
                                    widget.user.fullname!,
                                    widget.proposal.studentUser!.user!,
                                    widget.user,
                                    1);
                              })
                            : setState(() {
                                // ProposalViewModel(context)
                                //     .setStatusFlagProject(widget.proposal);
                                ControllerRoute(context).navigateToChatRoom(
                                    widget.user.id!,
                                    widget.proposal.studentUser!.userId!,
                                    widget.proposal.projectId!,
                                    widget.user.fullname!,
                                    widget.proposal.studentUser!.user!,
                                    widget.user,
                                    1);
                              });
                        print(isSendMessage);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(5)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(5),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: Text("Message  ",
                          style:
                              GoogleFonts.poppins(color: Colors.black, fontSize: 16.0)),
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: (widget.proposal.statusFlag == 0 ||
                              widget.proposal.statusFlag == 1)
                          ? () {
                              if (widget.proposal.statusFlag == 0 ||
                                  widget.proposal.statusFlag == 1) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Hired offer", style: GoogleFonts.poppins()),
                                        ],
                                      ),
                                      content: Text(
                                          "Do you really want to send hired offer for student to do this project?", style: GoogleFonts.poppins()),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 120,
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: BorderSide(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                child: Text("Cancel",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black)),
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    10), // Add a little space between the buttons
                                            Container(
                                              width: 120,
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    widget.proposal.statusFlag =
                                                        2;
                                                    ProposalViewModel(context)
                                                        .setStatusFlagProject(
                                                            widget.proposal);
                                                  });
                                                  // Handle send action here
                                                  Navigator.of(context).pop();
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.blue),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                                child: Text("Send",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // Handle hire action here
                              }
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor: widget.proposal.statusFlag == 2
                            ? MaterialStateProperty.all<Color>(Colors.grey)
                            : (widget.proposal.statusFlag == 2
                                ? MaterialStateProperty.all<Color>(
                                    Colors.greenAccent)
                                : MaterialStateProperty.all<Color>(
                                    Color(0xFF69cde0))),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(5)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(5),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: Text(
                        widget.proposal.statusFlag == 2
                            ? "Send hired offer"
                            : "Hire",
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
