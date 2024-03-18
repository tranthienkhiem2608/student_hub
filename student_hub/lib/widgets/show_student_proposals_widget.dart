import 'package:flutter/material.dart';
import 'package:student_hub/models/student_registered.dart';


class ShowStudentProposalsWidget extends StatefulWidget {
  StudentRegistered studentRegistered;
  String yearStudent;
  Function hireStudent;


  ShowStudentProposalsWidget({
    required this.studentRegistered,
    required this.yearStudent,
    required this.hireStudent,

  });

  @override
  _ShowStudentProposalsWidgetState createState() => _ShowStudentProposalsWidgetState();
}

class _ShowStudentProposalsWidgetState extends State<ShowStudentProposalsWidget> {
  bool isHireOfferSent = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset('assets/images/user_img.png',
            width: 80,
                        height:80,),
            Padding(padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.studentRegistered.student.user.fullName,),
                Text(widget.yearStudent),
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
              Text(widget.studentRegistered.student.techStack),
              Text(widget.studentRegistered.student.techStack),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
        child:Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.studentRegistered.introductionStudent,
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
                onPressed: () {
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(5),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              child: Text("Message  ", style: TextStyle(color: Colors.black, fontSize: 16.0)),
            ),
            ),
            Container(
              width: 180,
              height: 45,
              child: ElevatedButton(
                onPressed: widget.studentRegistered.isHireOfferSent ? null : () {
                  if(widget.studentRegistered.statusStudent == "Send hire offer") {
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
                          content: Text("Do you really want to send hired offer for student to do this project?"),
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
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            side: BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  SizedBox(width: 10), // Add a little space between the buttons
                                  Container(
                                    width: 120,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.studentRegistered.isHireOfferSent = true;
                                        });
                                        // Handle send action here
                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      child: const Text("Send", style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                        );
                      },
                    );
                  }
                  else {
                    // Handle hire action here
                    onPressed: isHireOfferSent || widget.studentRegistered.statusStudent != "Hire"
                        ? null : widget.hireStudent(widget.studentRegistered);
                }
                },
                style: ButtonStyle(
                  backgroundColor: widget.studentRegistered.isHireOfferSent
                      ? MaterialStateProperty.all<Color>(Colors.grey)
                      : (widget.studentRegistered.statusStudent == "Hire"
                      ? MaterialStateProperty.all<Color>(Colors.greenAccent)
                      : MaterialStateProperty.all<Color>(Color(0xFF69cde0))),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
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
                  widget.studentRegistered.isHireOfferSent ? "Already sent" : (widget.studentRegistered.statusStudent == "Hire"
                      ? "Hire" : "Send hired offer"),
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