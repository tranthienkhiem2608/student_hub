import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:student_hub/models/model/education.dart';
import 'package:student_hub/models/model/language.dart';
import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/models/model/student_user.dart';
import 'package:student_hub/models/model/techStack.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/widgets/pop_up_education_widget.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:student_hub/widgets/show_school_widget.dart';
import 'package:student_hub/widgets/show_languages_widget.dart';
import 'package:student_hub/widgets/pop_up_languages_widget.dart';

import '../../../view_models/input_profile_viewModel.dart';
import '../../../widgets/pop_up_languages_edit_widget.dart';

class ProfileInputStudent1 extends StatefulWidget {
  final User user;
  const ProfileInputStudent1(this.user, {super.key});

  @override
  _ProfileInputStudent1State createState() => _ProfileInputStudent1State();
}

class _ProfileInputStudent1State extends State<ProfileInputStudent1> {
  late TextfieldTagsController<String> _textfieldTagsController;
  late double _distanceToField;
  final List<String> _selectedSkills = [];
  String _selectedTechStack = '';
  final List<int> _selectedSkillsId = [];
  int _selectedTechStackId = 0;
  List<SkillSets> _selectedSkillSet = [];
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

  void _addNewLanguage(String language, String level) {
    setState(() {
      print("ID: ${widget.user.id}, Language: $language, Level: $level");
      final Language newLanguage = Language(
        languageName: language,
        level: level,
      );
      languages.add(newLanguage);
    });
  }

  void _deleteLanguage(String language) {
    setState(() {
      languages.removeWhere((element) => element.languageName == language);
    });
  }

  void _addNewEducation(String schoolName, int yearsStart, int yearsEnd) {
    setState(() {
      print(
          "ID: ${widget.user.id}, School: $schoolName, Start: $yearsStart, End: $yearsEnd");
      final Education newEducation = Education(
        schoolName: schoolName,
        startYear: yearsStart,
        endYear: yearsEnd,
      );
      educationList.add(newEducation);
    });
  }

  void _deleteEducation(String schoolName) {
    setState(() {
      educationList.removeWhere((element) => element.schoolName == schoolName);
    });
  }

  void _editLanguage(List<Map<String, dynamic>> listLanguagesDelete) {
    for (var i = 0; i < listLanguagesDelete.length; i++) {
      print(listLanguagesDelete[i]);
      if (languages.contains(listLanguagesDelete[i])) {
        setState(() {
          languages.removeWhere((element) => element == listLanguagesDelete[i]);
        });
      }
    }
  }

  List<SkillSets> skillsSets = [];
  List<Language> languages = [
    // Add more languages here
  ];

  List<Education> educationList = [
    // Add more education items here
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Student Hub',
            style: GoogleFonts.poppins(
                // Apply the Poppins font
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: <Widget>[
          IconButton(
            icon: Container(
              // Add a Container as the parent
              padding: const EdgeInsets.all(8.0), // Padding for spacing
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.circle,
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
                child: Image.asset('assets/icons/user_ic.png',
                    width: 25, height: 25),
              ),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Align(
                alignment: Alignment.topCenter,
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Màu chữ mặc định
                    ),
                    children: [
                      TextSpan(
                        text: "Welcome to ",
                      ),
                      TextSpan(
                        text: "Student Hub",
                        style: TextStyle(
                            color:
                                Color(0xFF406AFF)), // Màu chữ của "Student Hub"
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                child: Text(
                  "Tell us about your self and you will be on your way connect with real-world project",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color.fromARGB(255, 90, 93, 104),
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Techstack",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
              width: 390,
              height: 50,
              child: DropdownSearch<TechStack>(
                asyncItems: (filter) async => getData(context, filter),
                compareFn: (item, selectedItem) => item == selectedItem,
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem?.name ?? "Select Techstack",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  );
                },
                onChanged: (TechStack? newValue) {
                  setState(() {
                    _selectedTechStack = newValue!.name;

                    print("chosen techstack: $_selectedTechStack");
                    _selectedTechStackId = newValue.id;
                    print("id: $_selectedTechStackId");
                  });
                },
                popupProps: const PopupProps.menu(
                  constraints: BoxConstraints(
                    maxHeight: 250, // Đặt giới hạn chiều cao tối đa
                  ),
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
                    cursorColor: Color(0xFF406AFF),
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
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) async {
                skillsSets = await getDataSkillSet(context);
                if (textEditingValue.text == '') {
                  return Future.value(
                      skillsSets.map((skillSet) => skillSet.name ?? ''));
                }
                return skillsSets
                    .where((skillSet) => skillSet.name!
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                    .map((skillSet) => skillSet.name ?? " ")
                    .toList();
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
                                        _selectedSkillsId.add(skillsSets
                                            .firstWhere((element) =>
                                                element.name == option)
                                            .id!);
                                        //add id and name skillSet to _selectedSkillsId
                                        _selectedSkillSet.add(
                                            skillsSets.firstWhere((element) =>
                                                element.name == option));
                                      }
                                      setState(() {});
                                    },
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 15),
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
                                  color: Color(0xFF406AFF), width: 2.0),
                            ),
                            hintText: inputFieldValues.tags.isNotEmpty
                                ? ''
                                : "Add your skills",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 13, color: Colors.grey),
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
                                                Radius.circular(10.0),
                                              ),
                                              color: Color(0xFF4DBE3FF),
                                            ),
                                            margin: const EdgeInsets.only(
                                                right: 0.0),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  child: Row(
                                                    children: [
                                                      // This is the user icon
                                                      Text(
                                                        tag,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                // Đổi font thành Poppins
                                                                color: Color(
                                                                    0xFF406AFF)),
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
                                                    color: Color(0xFF406AFF),
                                                  ),
                                                  onTap: () {
                                                    inputFieldValues
                                                        .onTagDelete(tag);
                                                    if (_selectedSkills
                                                        .contains(tag)) {
                                                      _selectedSkills
                                                          .remove(tag);
                                                      _selectedSkillsId.remove(
                                                          skillsSets
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .name ==
                                                                      tag)
                                                              .id);
                                                      _selectedSkillSet
                                                          .removeWhere(
                                                              (element) =>
                                                                  element
                                                                      .name ==
                                                                  tag);
                                                    }
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                : null,
                          ),
                          style: GoogleFonts
                              .poppins(), // Đổi font chữ thành Poppins
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
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(160, 10, 0, 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () async {
                        final result = await showDialog<Language>(
                          context: context,
                          builder: (BuildContext context) {
                            return PopUpLanguagesWidget(
                                _addNewLanguage, languages);
                          },
                        );

                        if (result != null) {
                          setState(() {
                            languages.add(result);
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 26,
                        color: Color(0xFF406AFF),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopUpLanguagesEditWidget(
                            _deleteLanguage, languages);
                      },
                    );
                  },
                  icon: Image.asset(
                    'assets/icons/edit.jpg', // Đường dẫn đến hình ảnh edit.jpg
                    width: 20, // Kích thước của hình ảnh
                    height: 20,
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
                          color: Color.fromARGB(
                              255, 190, 190, 192), // Set border color
                          width: 1, // Set border width
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 120,
                      child: ShowLanguagesWidget(
                          languages: languages,
                          isEditing: true,
                          deleteLanguage: _deleteLanguage),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Education",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(220, 10, 0, 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PopUpEducationEditWidget(
                                _addNewEducation, _deleteEducation, " ", 0, 0);
                          },
                        );
                      },
                      icon: const Icon(Icons.add,
                          size: 26, color: Color(0xFF406AFF)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(
                              255, 190, 190, 192), // Set border color
                          width: 1, // Set border width
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 170,
                      child: ShowSchoolWidget(
                        educationList: educationList,
                        deleteSchool: _deleteEducation,
                        addNewEducation: _addNewEducation,
                        isEditing: true,
                      ),
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
                    onPressed: () {
                      print(
                          "Techstack: $_selectedTechStackId - $_selectedTechStack");
                      for (var i = 0; i < _selectedSkills.length; i++) {
                        print(
                            "SkillSet: ${_selectedSkillSet[i].id} - ${_selectedSkillSet[i].name}");
                      }
                      for (var i = 0; i < languages.length; i++) {
                        print(
                            "Language: ${languages[i].languageName} - ${languages[i].level}");
                      }

                      if (_selectedTechStackId != 0 &&
                          _selectedSkillsId.isNotEmpty) {
                        widget.user.studentUser = StudentUser(
                          id: widget.user.id!,
                          userId: widget.user.id!,
                          techStackId: _selectedTechStackId,
                          skillSet: _selectedSkillSet ?? [],
                          languages: languages ?? [],
                          education: educationList ?? [],
                          experience: [],
                        );
                        ControllerRoute(context)
                            .navigateToProfileInputStudent2(widget.user);
                      } else {
                        //show dialog to choose techstack and skillset
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: _selectedSkillsId.isEmpty
                                      ? const Text('Skillset is empty')
                                      : const Text('Techstack is empty'),
                                  content: _selectedSkillsId.isEmpty
                                      ? const Text(
                                          'Please choose at least one skillset')
                                      : const Text('Please choose a techstack'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      }
                      // ControllerRoute(context)
                      //     .navigateToProfileInputStudent2(widget.user);
                    },
                    height: 45,
                    color: Color(0xFF406AFF),
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
      automaticallyImplyLeading: false,
      title: const Text('Student Hub',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
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

Widget _customItemBuilder(
    BuildContext context, TechStack item, bool isSelected) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 10),
      child: Column(
        children: [
          Text(
            item.name,
            style: TextStyle(
              color: isSelected ? Color(0xFF406AFF) : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Divider(
            color: Color(0xFF777B8A),
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

Future<List<TechStack>> getData(BuildContext context, String? filter) async {
  List<TechStack> skillsTechList =
      await InputProfileViewModel(context).getTechStack();

  await Future.delayed(const Duration(milliseconds: 200));
  if (filter!.isNotEmpty) {
    return skillsTechList
        .where((element) =>
            element.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

  return skillsTechList;
}

Future<List<SkillSets>> getDataSkillSet(BuildContext context) async {
  await Future.delayed(const Duration(milliseconds: 200));
  List<SkillSets> skillsList =
      await InputProfileViewModel(context).getSkillSets();

  return skillsList;
}
