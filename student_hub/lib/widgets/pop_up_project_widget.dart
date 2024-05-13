import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/view_models/input_profile_viewModel.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
// import 'package:flutter_month_picker/flutter_month_picker.dart';

class PopUpProjectWidget extends StatefulWidget {
  final Function addProject;
  final Function deleteProject;
  final String projectName;
  final DateTime? timeStart;
  final DateTime? timeEnd;
  final String projectDescription;
  final List<SkillSets> skillsListProject;

  const PopUpProjectWidget(
      this.addProject,
      this.deleteProject,
      this.projectName,
      this.timeStart,
      this.timeEnd,
      this.projectDescription,
      this.skillsListProject,
      {Key? key})
      : super(key: key);
  @override
  _PopUpProjectWidgetState createState() => _PopUpProjectWidgetState();
}

class _PopUpProjectWidgetState extends State<PopUpProjectWidget> {
  late DateTime? _timeStart = widget.timeStart;
  late DateTime? _timeEnd = widget.timeEnd;
  late TextEditingController _projectNameController;
  late TextEditingController _projectDescriptionController;
  final List<String>? _selectedSkills = [];
  final List<int>? _selectedSkillsId = [];
  final List<SkillSets> _skillsListProject = [];
  TextEditingController _textEditingController = TextEditingController();
  late TextfieldTagsController<String> _textfieldTagsController;
  late double _distanceToField;
  List<SkillSets> skillsSets = [];

  @override
  void initState() {
    super.initState();
    _projectNameController = TextEditingController(text: widget.projectName);
    _projectDescriptionController =
        TextEditingController(text: widget.projectDescription);
    _textfieldTagsController = TextfieldTagsController<String>();
    _selectedSkills!.addAll(widget.skillsListProject.map((e) => e.toString()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _textfieldTagsController.dispose();
  }

  void _showStartDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _timeStart = value;
      });
    });
  }

  void _showStartMonthPicker() {
    showMonthPicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _timeStart = date;
      });
    });
  }

  void _showEndMonthPicker() {
    showMonthPicker(
      context: context,
      initialDate: _timeStart!
          .add(Duration(days: 1)), // start from the day after the start date
      firstDate: _timeStart!.add(Duration(
          days:
              1)), // the first date that can be picked is the day after the start date
      lastDate: DateTime
          .now(), // the last date that can be picked is 5 years after the start date
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _timeEnd = value;
      });
    });
  }

  void _showEndDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _timeStart
          ?.add(Duration(days: 1)), // start from the day after the start date
      firstDate: _timeStart!.add(Duration(
          days:
              1)), // the first date that can be picked is the day after the start date
      lastDate: DateTime
          .now(), // the last date that can be picked is 5 years after the start date
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _timeEnd = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return AlertDialog(
      backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 10, 10),
        child: Text(
          'popup_project1'.tr(),
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF406AFF),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('popup_project2'.tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  )),
            ),
            TextField(
              style: GoogleFonts.poppins(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              cursorColor: Color(0xFF406AFF),
              controller: _projectNameController,
              decoration: InputDecoration(
                hintText: 'popup_project3'.tr(),
                hintStyle: GoogleFonts.poppins(
                  // Sử dụng font Poppins
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF406AFF), width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('popup_project4'.tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      )),
                  Text(
                    _timeStart == null
                        ? 'popup_project5'.tr()
                        : DateFormat.yM().format(_timeStart!),
                    style:
                        GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_month_sharp,
                      color: Color(0xFF406AFF),
                      size: 20.0,
                    ),
                    onPressed: _showStartMonthPicker,
                  ),
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('popup_project6'.tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
                Text(
                  _timeEnd == null
                      ? 'popup_project5'.tr()
                      : DateFormat.yM().format(_timeEnd!),
                  style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_month_sharp,
                      color: Color(0xFF406AFF), size: 20.0, ),
                  onPressed: _showEndMonthPicker,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('popup_project7'.tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      )),
                ),
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) async {
                    skillsSets = await getDataSkillSet(context);
                    if (textEditingValue.text == '') {
                      return Future.value(
                          skillsSets.map((skillSet) => skillSet.name));
                    }
                    return skillsSets
                        .where((skillSet) => skillSet.name
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                        .map((skillSet) => skillSet.name)
                        .toList();
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 5.0,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxHeight: 200, maxWidth: 250),
                            child: ListView.builder(
                              padding: EdgeInsets.only(left: 10.0),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final dynamic option = options.elementAt(index);
                                return option.toLowerCase().contains(
                                        _textEditingController.text
                                            .toLowerCase())
                                    ? TextButton(
                                        onPressed: () {
                                          onSelected(option);
                                          if (_skillsListProject
                                                  .contains({'name': option}) ==
                                              false) {
                                            if (_skillsListProject
                                                .where((element) =>
                                                    element.name == option)
                                                .isEmpty) {
                                              _skillsListProject.add(skillsSets
                                                  .where((element) =>
                                                      element.name == option)
                                                  .first);
                                            }
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '$option',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                if (_skillsListProject
                                                    .contains({'name': option}))
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
                          return 'popup_project11'.tr();
                        }
                        return null;
                      },
                      inputFieldBuilder: (context, inputFieldValues) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 3.0),
                          child: SingleChildScrollView(
                            child: TextField(
                              controller:
                                  inputFieldValues.textEditingController,
                              focusNode: inputFieldValues.focusNode,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 3.0),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF406AFF), width: 1.2),
                                ),
                                hintText: inputFieldValues.tags.isNotEmpty
                                    ? ''
                                    : "popup_project8".tr(),
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize:
                                      14, // Đổi màu của hintText thành màu xám
                                ),
                                errorText: inputFieldValues.error,
                                prefixIconConstraints: BoxConstraints(
                                    maxWidth: _distanceToField * 0.90),
                                prefixIcon: inputFieldValues.tags.isNotEmpty
                                    ? SingleChildScrollView(
                                        controller: inputFieldValues
                                            .tagScrollController,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
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
                                                          style: GoogleFonts
                                                              .poppins(
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
                                                      if (_skillsListProject
                                                          .contains(
                                                              {'name': tag})) {
                                                        _skillsListProject
                                                            .removeWhere(
                                                                (element) {
                                                          return element.name ==
                                                              tag;
                                                        });
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
              ],
            ),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('popup_project9'.tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ))),
            SizedBox(height: 10),
            Container(
              width: 300.0,
              height: 160.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextFormField(
                style: GoogleFonts.poppins(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              cursorColor: Color(0xFF406AFF),
                controller: _projectDescriptionController,
                decoration: InputDecoration(
                  hintText: 'popup_project10'.tr(),
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(244, 213, 222, 255),
          ),
          child: Text('popup_language5'.tr(),
              style: GoogleFonts.poppins(
                  color: Color(0xFF406AFF), fontWeight: FontWeight.w500)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFF406AFF),
          ),
          child: Text('popup_education8'.tr(),
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w500)),
          onPressed: () {
            // Handle the Add button press
            // You can access the project name using _projectNameController.text
            // You can access the project description using _projectDescriptionController.text
            widget.deleteProject(_projectNameController.text);
            widget.addProject(
              _projectNameController.text,
              _timeStart,
              _timeEnd,
              _projectDescriptionController.text,
              _skillsListProject,
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

Future<List<SkillSets>> getDataSkillSet(BuildContext context) async {
  await Future.delayed(const Duration(milliseconds: 200));
  List<SkillSets> skillsList =
      await InputProfileViewModel(context).getSkillSets();

  return skillsList;
}
