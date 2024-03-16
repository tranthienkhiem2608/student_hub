import 'package:flutter/material.dart';
import 'package:student_hub/views/pages/message_page.dart';
import 'package:student_hub/views/pages/project_detail/detail_page.dart';
import 'package:student_hub/views/pages/project_detail/hired_page.dart';
import 'package:student_hub/views/pages/project_detail/message_page.dart';
import 'package:student_hub/views/pages/project_detail/proposals_page.dart';


class HireStudentScreen extends StatefulWidget {

  const HireStudentScreen({super.key});

  @override
  _HireStudentScreenState createState() => _HireStudentScreenState();

}

class _HireStudentScreenState extends State<HireStudentScreen> {

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: _AppBar(),
        body: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.fromLTRB(25, 5, 5, 0),
              child:Align(
                alignment: Alignment.centerLeft,
                child:Text("Senior frontend developer (Fintech)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),),
              ),
            ),
            TabBar(
              indicatorColor: Color(0xFF69cde0),
              labelColor: Color(0xFF69cde0),
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Proposals'),
                Tab(text: 'Details'),
                Tab(text: 'Messages'),
                Tab(text: 'Hired'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ProposalsPage(),
                  DetailPage(),
                  MessagePage(),
                  HiredPage(),
                ],
              ),
            ),
          ],
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