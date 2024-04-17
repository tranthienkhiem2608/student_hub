import 'package:flutter/material.dart';
import 'package:student_hub/models/model/education.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/student_user.dart';

class ShowStudentProposalsWidget extends StatefulWidget {
  Proposal proposal;
  Function hireStudent;

  ShowStudentProposalsWidget({
    required this.proposal,
    required this.hireStudent,
  });

  @override
  _ShowStudentProposalsWidgetState createState() =>
      _ShowStudentProposalsWidgetState();
}

class _ShowStudentProposalsWidgetState
    extends State<ShowStudentProposalsWidget> {
  bool isHireOfferSent = false;
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
          return '3rd year student';
        case 2:
          return '2nd year student';
        case 3:
          return '1st year student';
        case 0:
          return '4th year student';
        default:
          return '${(closestEducation.endYear! - closestEducation.startYear!) - (closestEducation.endYear! - currentYear)}th year student';
      }
    } else {
      return 'graduated';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/user_img.png',
              width: 80,
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.proposal.studentUser!.user!,
                  ),
                  Text(getText()),
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
              Text(widget.proposal.studentUser!.techStack!.name),
              Text(widget.proposal.studentUser!.techStack!.name),
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
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 180,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(5),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: Text("Message  ",
                    style: TextStyle(color: Colors.black, fontSize: 16.0)),
              ),
            ),
            Container(
              width: 180,
              height: 45,
              child: ElevatedButton(
                onPressed: widget.proposal.statusFlag == 1
                    ? () {
                        if (widget.proposal.statusFlag == 1) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Hired offer"),
                                  ],
                                ),
                                content: Text(
                                    "Do you really want to send hired offer for student to do this project?"),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 120,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          child: const Text("Cancel",
                                              style: TextStyle(
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
                                              widget.proposal.statusFlag = 0;
                                            });
                                            // Handle send action here
                                            Navigator.of(context).pop();
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blue),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          child: const Text("Send",
                                              style: TextStyle(
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
                          onPressed() =>
                              isHireOfferSent || widget.proposal.statusFlag != 2
                                  ? null
                                  : widget.hireStudent(widget.proposal);
                        }
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: widget.proposal.statusFlag == 0
                      ? MaterialStateProperty.all<Color>(Colors.grey)
                      : (widget.proposal.statusFlag == 2
                          ? MaterialStateProperty.all<Color>(Colors.greenAccent)
                          : MaterialStateProperty.all<Color>(
                              Color(0xFF69cde0))),
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(5),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: Text(
                  widget.proposal.statusFlag == 0
                      ? "Already sent"
                      : (widget.proposal.statusFlag == 2
                          ? "Hire"
                          : "Send hired offer"),
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
