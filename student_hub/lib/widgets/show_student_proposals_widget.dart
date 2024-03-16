import 'package:flutter/material.dart';


class ShowStudentProposalsWidget extends StatefulWidget {
  String nameStudentProposals;
  String yearStudent;
  String techStack;
  String levelStudent;
  String description;
  String status;

  ShowStudentProposalsWidget({
    required this.nameStudentProposals,
    required this.yearStudent,
    required this.techStack,
    required this.levelStudent,
    required this.description,
    required this.status,
  });

  @override
  _ShowStudentProposalsWidgetState createState() => _ShowStudentProposalsWidgetState();
}

class _ShowStudentProposalsWidgetState extends State<ShowStudentProposalsWidget> {

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
                Text(widget.nameStudentProposals),
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
              Text(widget.techStack),
              Text(widget.levelStudent),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
        child:Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.description,
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
                onPressed: () {
                },
                style: ButtonStyle(
                  backgroundColor: widget.status == "Hire" ? MaterialStateProperty.all<Color>(Colors.greenAccent) : MaterialStateProperty.all<Color>(Color(0xFF69cde0)),
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
                  widget.status == "Hire" ? "Hire" : "Send hired offer",
                  style: widget.status == "Hire" ? TextStyle(color: Colors.black, fontSize: 16.0) : TextStyle(color: Colors.black, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}