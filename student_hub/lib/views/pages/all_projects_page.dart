import 'package:flutter/material.dart';

class AllProjectsPage extends StatelessWidget {
  const AllProjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[];// sau thay thế bằng modle của projects
    final String username = "John";
    return Visibility(
      replacement: Center(
      child: Text("\t\tWelcome, $username \nYou no have jobs"),
    ),
    visible: entries.isNotEmpty,
    child: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Expanded(
          child: ListView.separated(
            itemCount: entries.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => ListTile(
              title: Text('Project ${entries[index]}'),
              subtitle: Text('Description of project ${entries[index]}'),
              onTap: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/project_detail');
              },
            ),
          ),
        ),
      ]),
    ),
    );
  }
}