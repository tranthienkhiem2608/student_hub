import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:student_hub/models/model/file_cv.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';
// import 'package:student_hub/views/profile_creation/student/home_view.dart';

import 'package:student_hub/models/model/student_user.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/input_profile_viewModel.dart';

class StudentProfileDragCv extends StatefulWidget {
  final User studentUser;

  const StudentProfileDragCv(this.studentUser, {super.key});

  @override
  State<StudentProfileDragCv> createState() => _StudentProfileDragCvState();
}

class _StudentProfileDragCvState extends State<StudentProfileDragCv> {
  File? _cvFile;
  PlatformFile? _cvPlatformFile;
  File? _transcriptFile;
  PlatformFile? _transcriptPlatformFile;
  DropzoneViewController? _dropzoneController;
  FileCV? fileCV;

  Future<void> _selectCvFile() async {
    if (kIsWeb) {
      // Web: Use Drag and Drop
      final events = await _dropzoneController!.pickFiles();
      if (events.isEmpty) return;

      final file = events.first;
      setState(() {
        _cvFile = File(file.path!);
        _cvPlatformFile = PlatformFile(
          name: file.name,
          size: file.size,
          //get path of file
          path: file.path,
        );
      });
    } else {
      // Mobile: Use File Picker
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'], // Example file types
      );
      if (result == null) return;

      final file = File(result.files.single.path!);
      setState(() {
        _cvFile = file;

        print("PATH: ${file.path}");
        _cvPlatformFile = result.files.first;
      });
    }
  }

  Future<void> _selectTranscriptFile() async {
    if (kIsWeb) {
      // Web: Use Drag and Drop
      final events = await _dropzoneController!.pickFiles();
      if (events.isEmpty) return;

      final file = events.first;
      setState(() {
        _transcriptFile = File(file.path!);
        _transcriptPlatformFile = PlatformFile(
          name: file.name,
          size: file.size,
        );
      });
    } else {
      // Mobile: Use File Picker
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'], // Example file types
      );
      if (result == null) return;

      final file = File(result.files.single.path!);
      setState(() {
        _transcriptFile = file;

        print("PATH: ${file.path}");
        _transcriptPlatformFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "CV & Transcript",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Text(
                "Tell us about your self and you will be on your way connect with real-world project",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            // Resume/CV(*)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Text(
                "Resume/CV(*)",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            if (!kIsWeb)
              buildUploadArea(
                  title:
                      'Drag and drop your Resume/CV here or\nSelect your file',
                  onTap: _selectCvFile), // Call with _selectCvFile

            if (_cvFile != null)
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  children: [
                    Text('Selected CV File: ${_cvPlatformFile!.name}'),
                  ],
                ),
              ),

            // upload Transcript(*)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Text(
                "Transcript(*)",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            if (!kIsWeb)
              buildUploadArea(
                  title:
                      'Drag and drop your Transcript here or\nSelect your file',
                  onTap:
                      _selectTranscriptFile), // Call with _selectTranscriptFile

            if (_transcriptFile != null)
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  children: [
                    Text(
                        'Selected Transcript File: ${_transcriptPlatformFile!.name}'),
                  ],
                ),
              ),
            // Next Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    fileCV = FileCV(
                      transcript: _transcriptPlatformFile?.path,
                      resume: _cvPlatformFile?.path,
                    );
                    widget.studentUser.studentUser?.file = fileCV;
                    print(
                        "CV: ${widget.studentUser.studentUser?.file?.resume}");
                    print(
                        "Transcript: ${widget.studentUser.studentUser?.file?.transcript}");
                    InputProfileViewModel(context)
                        .inputProfileStudent(widget.studentUser);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "Next",
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

  Widget buildUploadArea({required String title, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: DottedBorder(
          child: Container(
            width: double.infinity,
            height: 160,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/upload_img.png',
                    width: 150,
                    height: 150,
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.8), // Mờ hình ảnh
                    colorBlendMode: BlendMode.srcOver, // Áp dụng hiệu ứng mờ
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      backgroundColor: const Color(0xFFBEEEF7),
      actions: <Widget>[
        IconButton(
          icon: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset('assets/icons/user_ic.png'),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
