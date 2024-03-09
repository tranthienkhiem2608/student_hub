import 'package:flutter/material.dart';

class AllProjectsPage extends StatelessWidget {
  const AllProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B','C'];// sau thay thế bằng modle của projects
    const String username = "John";
    return Visibility(
      replacement: const Center(
      child: Text("\t\tWelcome, $username \nYou no have jobs"),
    ),
    visible: entries.isNotEmpty,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Expanded(
          child: ListView.separated(
            itemCount: entries.length,
            itemBuilder: (context, index) => Column(
              children: [
                ListTile(
                  title: Text('Project ${entries[index]}'),
                  subtitle: Text('Description of project ${entries[index]}'),
                  onTap: () {
                    // Navigate to the second screen using a named route.
                    Navigator.pushNamed(context, '/project_detail');
                  },
                ),
                const Divider(),
              ],
            ),
            separatorBuilder: (context, index) => const SizedBox(),
          ),
        ),
      ]),
    ),
    );
  }
}