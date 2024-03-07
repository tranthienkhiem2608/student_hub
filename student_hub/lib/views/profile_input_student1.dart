import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ProfileInputStudent1 extends StatefulWidget {
  ProfileInputStudent1({Key? key}) : super(key: key);

  @override
  _ProfileInputStudent1State createState() => _ProfileInputStudent1State();
}

class _ProfileInputStudent1State extends State<ProfileInputStudent1> {
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
                  "Welcome to Student Hub",
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
              child: Align(
                alignment: Alignment.centerLeft,
              child:Text(
                "Techstack",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              ),
            ),
            Container(
              width: 350,
              height: 50,
              child: DropdownSearch<String>(

                asyncItems: (filter) async => await getData(filter),
                compareFn: (item, selectedItem) => item == selectedItem,
                dropdownBuilder: (context, selectedItem) {
                  return Text(selectedItem ?? "Select Techstack");
                },
                popupProps: const PopupProps.menu(
                  isFilterOnline: true,
                  showSearchBox: true,
                  showSelectedItems: true,
                  loadingBuilder:_customLoadingBuilder,
                  itemBuilder: _customItemBuilder,
                  favoriteItemProps: FavoriteItemProps(
                    showFavoriteItems: true,
                    favoriteItemsAlignment: MainAxisAlignment.start,
                  ),
                  searchFieldProps: TextFieldProps(
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      labelText: "Search Techstack",
                      hintText: "Search Techstack",
                    ),
                  ),
                ),
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
              height: 200,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Search Skills'),
                      onChanged: (value) => setState(() => _searchQuery = value),
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
                        onDeleted: () =>
                            setState(() => _selectedSkills.remove(skill)),
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
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
          const Divider(color: Colors.black,thickness: 0.2,),
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
  if(filter!.isNotEmpty){
    return skills.where((skill) => skill.toLowerCase().contains(filter.toLowerCase())).toList();
  }
  return skills;
}