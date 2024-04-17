import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/model/project_company.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.projectCompany});
  final ProjectCompany projectCompany;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  List<String> expectations = [];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
// To store the parsed expectations

  void _parseExpectations() {
    // Assuming your expectations are separated by newlines in the description
    setState(() {
      expectations = widget.projectCompany.description!.split('\n');
    });
  }

  @override
  void initState() {
    super.initState();
    _parseExpectations();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.6, 1, curve: Curves.fastOutSlowIn)),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.search),
                SizedBox(height: 10),
                SizedBox(width: 12),
                Text(
                  'Student are looking for:',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              children: expectations.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 36),
                      Container(
                        margin: EdgeInsets.only(top: 8, right: 10),
                        width: 4,
                        height: 9,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                          child: Text(item,
                              style: GoogleFonts.poppins(fontSize: 15.5))),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 5),
                width: 20, // Adjust the width for the larger icon
                height: 20, // Adjust the height for the larger icon
                child: Icon(Icons.watch_later_outlined, size: 25),
              ),
              title: Text(
                'Project scope:',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${widget.projectCompany.projectScopeFlag} months',
                style: GoogleFonts.poppins(fontSize: 15),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 5),
                width: 20, // Adjust the width for the larger icon
                height: 20, // Adjust the height for the larger icon
                child: Icon(Icons.people_alt_outlined, size: 25),
              ),
              title: Text(
                'Student required:',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
               '${widget.projectCompany.numberOfStudents} students',
                style: GoogleFonts.poppins(fontSize: 15.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
