import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_hub/views/home_view.dart';

class StudentProfileDragCv extends StatefulWidget {
  const StudentProfileDragCv({super.key});

  @override
  State<StudentProfileDragCv> createState() => _StudentProfileDragCvState();
}

class _StudentProfileDragCvState extends State<StudentProfileDragCv> {
  File? _cvFile;
  PlatformFile? _cvPlatformFile;
  File? _transcriptFile;
  PlatformFile? _transcriptPlatformFile;
  DropzoneViewController? _dropzoneController;

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
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Text(
                "Tell us about your self and you will be on your way connect with real-world project",
                style: GoogleFonts.openSans(
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
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
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
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(300, 15, 20, 5),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF69cde0),
                  ),
                ),
                onPressed: () async {
                  // 1. Simulate some processing (if needed)
                  // You would perform your upload logic or other tasks here.
                  await Future.delayed(
                      const Duration(milliseconds: 100)); // Example delay

                  // 3. Navigate to HomePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomePage(showAlert: true), // Pass true
                    ),
                  );
                },
                child:
                    const Text('Next', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUploadArea({required String title, required Function onTap}) {
    //Add parameters
    return GestureDetector(
      onTap: () => onTap(), // Call the appropriate _select...File function
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: DottedBorder(
          child: Container(
            width: double.infinity,
            height: 160,
            child: Center(
              child: Text(
                title, // Use the title parameter
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
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
              color: Colors.blueAccent,
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
