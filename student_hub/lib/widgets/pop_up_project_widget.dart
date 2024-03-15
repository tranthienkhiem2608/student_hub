import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/models/project_student.dart';
import 'package:textfield_tags/textfield_tags.dart';


class PopUpProjectWidget extends StatefulWidget {
  final Function addProject;
  final Function deleteProject;
  final String projectName;
  final DateTime? timeStart;
  final DateTime? timeEnd;
  final String projectDescription;
  final List<String> skillsListProject;

  const PopUpProjectWidget(this.addProject, this.deleteProject, this.projectName, this.timeStart, this.timeEnd, this.projectDescription, this.skillsListProject, {Key? key}) : super(key: key);
  @override
  _PopUpProjectWidgetState createState() => _PopUpProjectWidgetState();
}

class _PopUpProjectWidgetState extends State<PopUpProjectWidget> {
  late DateTime? _timeStart = widget.timeStart;
  late DateTime? _timeEnd = widget.timeEnd;
  late TextEditingController _projectNameController;
  late TextEditingController _projectDescriptionController;
  final List<String>? _selectedSkills = [];
  TextEditingController _textEditingController = TextEditingController();
  late TextfieldTagsController<String> _textfieldTagsController;
  late double _distanceToField;





  @override
  void initState() {
    super.initState();
    _projectNameController = TextEditingController(text: widget.projectName);
    _projectDescriptionController = TextEditingController(text: widget.projectDescription);
    _textfieldTagsController = TextfieldTagsController<String>();
    _selectedSkills!.addAll(widget.skillsListProject);
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
        lastDate: DateTime.now()).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _timeStart = value;
      });
    });
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

  void _showEndDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _timeStart?.add(Duration(days: 1)), // start from the day after the start date
      firstDate: _timeStart!.add(Duration(days: 1)), // the first date that can be picked is the day after the start date
      lastDate: DateTime.now(), // the last date that can be picked is 5 years after the start date
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
    return AlertDialog(
      title: Text('Add Project'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          const Align(
          alignment: Alignment.centerLeft,
           child: Text('Project Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
            TextField(
              controller: _projectNameController,
              decoration: const InputDecoration(
                hintText: 'Enter project name',
              ),
            ),

            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Start Date', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(
                    _timeStart == null
                        ? 'No Date Chosen'
                        : DateFormat.yMd().format(_timeStart!),
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month_sharp, color: Colors.blueGrey),
                    onPressed: _showStartDatePicker,
                  ),
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('End Date', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  _timeEnd == null
                      ? 'No Date Chosen'
                      : DateFormat.yMd().format(_timeEnd!),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_month_sharp, color: Colors.blueGrey),
                  onPressed: _showEndDatePicker,
                ),
              ],
            ),
            SizedBox(height: 10),
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
                                if (!_selectedSkills!.contains(option)) {
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
                                          !.contains(option))
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
                                            Radius.circular(10.0),
                                          ),
                                          color: Colors.lightBlueAccent,
                                        ),
                                        margin:
                                        const EdgeInsets.only(right: 0.0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  const Icon(Icons
                                                      .person), // This is the user icon
                                                  Text(
                                                    tag,
                                                    style: const TextStyle(
                                                        color: Colors.black),
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
                                                    !.contains(tag)) {
                                                  _selectedSkills.remove(tag);
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
            SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Project Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
            Container(
              width: 300.0,
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextFormField(
                controller: _projectDescriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter project description',
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
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            // Handle the Add button press
            // You can access the project name using _projectNameController.text
            // You can access the project description using _projectDescriptionController.text
            widget.addProject(
              _projectNameController.text,
              _timeStart,
              _timeEnd,
              _projectDescriptionController.text,
              _selectedSkills,
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}