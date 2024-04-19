import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';

class ApplyPage extends StatefulWidget {
  final ProjectCompany project;
  final int studentId;

  const ApplyPage({Key? key, required this.project, required this.studentId})
      : super(key: key);

  @override
  _ApplyPageState createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  String coverLetter = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Hub',
            style: GoogleFonts.poppins(
                // Apply the Poppins font
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: <Widget>[
          IconButton(
            icon: Container(
              // Add a Container as the parent
              padding: const EdgeInsets.all(8.0), // Padding for spacing
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.circle,
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
                child: Image.asset('assets/icons/user_ic.png',
                    width: 25, height: 25),
              ),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cover Letter',
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Decribe why do you fit to this project.',
              style: GoogleFonts.poppins(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 500.0,
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF777B8A)),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextFormField(
                onChanged: (value) {
                  // Xử lý khi người dùng nhập vào
                  coverLetter = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter project description',
                  hintStyle: GoogleFonts.poppins(
                      color: Color(0xFF777B8A), fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nút "Cancel" được nhấn
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4DBE3FF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Color(0xFF406AFF), fontSize: 16.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Proposal proposal = Proposal(
                        studentId: widget.studentId,
                        projectId: widget.project.id,
                        coverLetter: coverLetter);

                    ProposalViewModel(context).postSendApply(proposal);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF406AFF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "Submit Proposal",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
