import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:student_hub/widgets/show_school_widget.dart';
import 'package:student_hub/widgets/show_languages_widget.dart';

class ProfileInputStudent1 extends StatefulWidget {
  const ProfileInputStudent1({Key? key}) : super(key: key);

  @override
  _ProfileInputStudent1State createState() => _ProfileInputStudent1State();
}

class _ProfileInputStudent1State extends State<ProfileInputStudent1> {
  late TextfieldTagsController<String> _textfieldTagsController;
  late double _distanceToField;
  final _selectedSkills = <String>[];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _textfieldTagsController = TextfieldTagsController<String>();
  }

  @override
  void dispose() {
    super.dispose();
    _textfieldTagsController.dispose();
  }

  final List<String> skills = [
    'Flutter',
    'Dart',
    'Java',
    'Kotlin',
    'Python',
    'C++',
    'C#',
    'C',
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
  ];
  List<Map<String, dynamic>> languages = [
    {'name': 'English', 'level': 'Native'},
    {'name': 'French', 'level': 'Intermediate'},
    {'name': 'Spanish', 'level': 'Basic'},
    // Add more languages here
  ];

  List<Map<String, dynamic>> educationList = [
    {'schoolName': 'Le Hong Phong High School', 'yearsStart': 2018, 'yearsEnd': 2021},
    {'schoolName': 'HCM University of Sciences', 'yearsStart': 2021, 'yearsEnd':2025},
    // Add more education items here
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const _AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Welcome to Student Hub",
                  style: GoogleFonts.openSans(
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
                child: Text(
                  "Techstack",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
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
                  loadingBuilder: _customLoadingBuilder,
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
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return skills; // return all skills when input is empty
                }
                return skills.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      elevation: 5.0,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final dynamic option = options.elementAt(index);
                            return option.toLowerCase().contains(
                                    _textEditingController.text.toLowerCase())
                                ? TextButton(
                                    onPressed: () {
                                      onSelected(option);
                                      if (!_selectedSkills.contains(option)) {
                                        _selectedSkills.add(option);
                                      }
                                      setState(() {});
                                    },
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '$option',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            if (_selectedSkills
                                                .contains(option))
                                              const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container();
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              onSelected: (String selectedTag) {
                _textfieldTagsController.onSubmitted(selectedTag);
              },
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                _textEditingController =
                    textEditingController; // Save the TextEditingController
                return TextFieldTags<String>(
                  textEditingController: textEditingController,
                  focusNode: focusNode,
                  textfieldTagsController: _textfieldTagsController,
                  letterCase: LetterCase.normal,
                  validator: (String tag) {
                    if (_textfieldTagsController.getTags!.contains(tag)) {
                      return 'You already entered that';
                    }
                    return null;
                  },
                  inputFieldBuilder: (context, inputFieldValues) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: inputFieldValues.textEditingController,
                          focusNode: inputFieldValues.focusNode,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 3.0),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFBEEEF7), width: 2.0),
                            ),
                            hintText: inputFieldValues.tags.isNotEmpty
                                ? ''
                                : "Add your skills",
                            errorText: inputFieldValues.error,
                            prefixIconConstraints: BoxConstraints(
                                maxWidth: _distanceToField * 0.90),
                            prefixIcon: inputFieldValues.tags.isNotEmpty
                                ? SingleChildScrollView(
                                    controller:
                                        inputFieldValues.tagScrollController,
                                    scrollDirection: Axis.horizontal,
                                    child: Wrap(
                                        children: inputFieldValues.tags
                                            .map((String tag) {
                                      return Padding(
                                        padding: const EdgeInsets.all(
                                            2.0), // Add padding here

                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                            color: Colors.lightBlueAccent,
                                          ),
                                          margin: const EdgeInsets.only(
                                              right: 0.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 4.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              InkWell(
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons
                                                        .person), // This is the user icon
                                                    Text(
                                                      tag,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  //print("$tag selected");
                                                },
                                              ),
                                              const SizedBox(width: 4.0),
                                              InkWell(
                                                child: const Icon(
                                                  Icons.cancel,
                                                  size: 14.0,
                                                  color: Color.fromARGB(
                                                      255, 233, 233, 233),
                                                ),
                                                onTap: () {
                                                  inputFieldValues
                                                      .onTagDelete(tag);
                                                  if (_selectedSkills
                                                      .contains(tag)) {
                                                    _selectedSkills
                                                        .remove(tag);
                                                  }
                                                  setState(() {});
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList()),
                                  )
                                : null,
                          ),
                          onChanged: inputFieldValues.onChanged,
                          onSubmitted: inputFieldValues.onSubmitted,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Row(
              children: [
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(160, 15, 0, 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add,
                          size: 26, color: Colors.lightBlue),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 0, 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, size: 23),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Set border color
                          width: 2, // Set border width
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 120,
                      child: ShowLanguagesWidget(languages: languages),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Education",
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(220, 15, 0, 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add,
                          size: 26, color: Colors.lightBlue),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Set border color
                          width: 2, // Set border width
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 160,
                      child: ShowSchoolWidget(educationList: educationList),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                      "Next",
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
  List<String> skillsTech = [
  'Mobile App Developer',
  'Web Developer',
  'Software Engineer',
  'Frontend Developer',
  'Backend Developer',
  'Full Stack Developer',
  'UI/UX Designer',
  'Data Scientist',
  'DevOps Engineer',
  'Cloud Architect',
  'Database Administrator',
  'Network Engineer',
  'Cyber Security Analyst',
  'Quality Assurance Engineer',
  'AI/Machine Learning Engineer',
  'Game Developer',
  'Blockchain Developer',
  'Embedded Systems Engineer',
  'IT Project Manager',
  'Technical Support Specialist',
  'Systems Analyst',
  'Business Analyst',
  'IT Consultant',
  'Network Administrator',
  'IT Trainer/Educator',
  'IT Sales Professional',
  'IT Operations Manager',
  'IT Director',
  'Chief Technology Officer (CTO)',
];
  await Future.delayed(const Duration(milliseconds: 200));
  if (filter!.isNotEmpty) {
    return skillsTech
        .where((skill) => skill.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }
  return skillsTech;
}
