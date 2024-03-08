import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ProfileInputStudent2 extends StatefulWidget {
  ProfileInputStudent2({Key? key}) : super(key: key);

  @override
  _ProfileInputStudent2State createState() => _ProfileInputStudent2State();
}

class _ProfileInputStudent2State extends State<ProfileInputStudent2> {
  final List<String> skills = [
    'Flutter',
    'Dart',
    'Java',
    'Kotlin',
    'Python',
    'C++',
    'C#',
    'Swift',
    'React',
    'Angular',
    'Vue',
    'Node.js',
    'Express.js',
    'MongoDB',
    'Firebase',
  ];

  List<String> _selectedSkills = [];
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final _selectedSkills = <String>[];
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
                  "Experiences",
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Projects",
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      // Add your logic here for handling the icon press
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Skillset",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 400,
              height: 250,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Search Skills'),
                      onChanged: (value) =>
                          setState(() => _searchQuery = value),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      children: skills
                          .where((skill) => skill
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()))
                          .map(
                            (skill) => InputChip(
                              label: Text(skill),
                              selected: _selectedSkills.contains(skill),
                              onSelected: (selected) => setState(() {
                                selected
                                    ? _selectedSkills.add(skill)
                                    : _selectedSkills.remove(skill);
                              }),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      children: _selectedSkills
                          .map((skill) => Chip(
                                label: Text(skill),
                                deleteIcon: Icon(Icons.close),
                                onDeleted: () => setState(
                                    () => _selectedSkills.remove(skill)),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Languages",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 80),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FadeTransition(
                  opacity: const AlwaysStoppedAnimation(1),
                  child: MaterialButton(
                    onPressed: () {},
                    height: 45,
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
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

Widget _customItemBuilder(BuildContext context, String item, bool isSelected) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
      child: Column(
        children: [
          Text(
            item,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.2,
          ),
        ],
      ));
}

Widget _customLoadingBuilder(BuildContext context, String item) {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.blue,
    ),
  );
}

Future<List<String>> getData(String? filter) async {
  List<String> skills = [
    'Flutter',
    'Dart',
    'Java',
    'Kotlin',
    'Python',
    'C++',
    'C#',
    'Swift',
    'React',
    'Angular',
    'Vue',
    'Node.js',
    'Express.js',
    'MongoDB',
    'Firebase',
    'SQL',
    'NoSQL',
    'HTML',
    'CSS',
    'JavaScript',
    'TypeScript',
    'Redux',
    'MobX',
    'GraphQL',
    'REST',
    'Docker',
    'Kubernetes',
    'Jenkins',
    'Git',
    'GitHub',
    'GitLab',
    'Bitbucket',
    'Jira',
    'Confluence',
    'Trello',
    'Slack',
    'Microsoft Teams',
    'Zoom',
    'Google Meet',
    'Skype',
    'WebRTC',
    'Agile',
    'Scrum',
    'Kanban',
    'Lean',
    'XP',
    'Pair Programming',
    'TDD',
    'BDD',
    'CI/CD',
    'DevOps',
    'Microservices',
    'Serverless',
    'TDD',
    'BDD',
    'CI/CD',
    'DevOps',
    'Microservices',
    'Serverless',
  ];
  await Future.delayed(const Duration(milliseconds: 200));
  if (filter!.isNotEmpty) {
    return skills
        .where((skill) => skill.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }
  return skills;
}
