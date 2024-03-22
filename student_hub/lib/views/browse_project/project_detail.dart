import 'package:flutter/material.dart';
import 'package:student_hub/views/browse_project/submit_proposal.dart';
import 'package:student_hub/widgets/project_list_widget.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectInfo project;

  const ProjectDetailPage({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
            onPressed: () {
              // Xử lý khi người dùng nhấn vào biểu tượng người dùng
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Detail',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              'Project Name: ${project.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              project.role,
              style: const TextStyle(
                color: Colors.green, // Màu xanh lá cho role
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 30),
            const Divider(
              height: 12,
              thickness: 1.5,
              color: Color.fromARGB(255, 54, 52, 52),
            ),
            SizedBox(height: 20),
            Text(
              'Student are looking for:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Sử dụng ListView để hiển thị danh sách các mục với dấu chấm đầu dòng
            ListView(
              shrinkWrap: true,
              children: project.expectations.split('\n').map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        width: 8, // Độ rộng của dấu chấm
                        height: 8, // Chiều cao của dấu chấm
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black, // Màu của dấu chấm
                        ),
                      ),
                      SizedBox(width: 10),
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
              title: Text(
                'Project scope:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${project.duration} months',
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
              title: Text(
                'Student required:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${project.students} students',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 170),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nút "Apply Now" được nhấn
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApplyPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, 
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "Apply Now",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "Save Project",
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