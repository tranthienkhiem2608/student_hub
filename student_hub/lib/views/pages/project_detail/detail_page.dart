import 'package:flutter/material.dart';

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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            const Divider(
              height: 12,
              thickness: 1.5,
              color: Color.fromARGB(255, 54, 52, 52),
            ),
            const SizedBox(height: 20),
            const Text(
              'Student are looking for:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Sử dụng ListView để hiển thị danh sách các mục với dấu chấm đầu dòng
            ListView(
              shrinkWrap: true,
              children: expectations.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        width: 8, // Độ rộng của dấu chấm
                        height: 8, // Chiều cao của dấu chấm
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black, // Màu của dấu chấm
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(item)),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            const Divider(
              height: 12,
              thickness: 1.5,
              color: Color.fromARGB(255, 54, 52, 52),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(top: 6),
                width: 40, // Adjust the width for the larger icon
                height: 40, // Adjust the height for the larger icon
                child: Icon(Icons.watch_later_outlined, size: 40),
              ),
              title: const Text(
                'Project scope:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${widget.projectCompany.projectScopeFlag} months',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(top: 6),
                width: 40, // Adjust the width for the larger icon
                height: 40, // Adjust the height for the larger icon
                child: Icon(Icons.people_alt_outlined, size: 40),
              ),
              title: const Text(
                'Student required:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${widget.projectCompany.numberOfStudents} students',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
