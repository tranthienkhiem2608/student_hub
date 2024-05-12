import 'package:flutter/material.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/view_models/project_company_viewModel.dart';

class EditProject extends StatefulWidget {
  EditProject({Key? key, required this.project}) : super(key: key);

  final ProjectCompany project;

  @override
  _EditProjectState createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _numberOfStudentsController = TextEditingController();
  TextEditingController _projectScopeFlagController = TextEditingController();

  bool _isEditMode = false; // Track whether the form is in edit mode

  @override
  void initState() {
    _titleController.text = widget.project.title!;
    _descriptionController.text = widget.project.description!;
    _numberOfStudentsController.text =
        widget.project.numberOfStudents.toString();
    _projectScopeFlagController.text =
        widget.project.projectScopeFlag.toString();

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _numberOfStudentsController.dispose();
    _projectScopeFlagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Project',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              enabled: _isEditMode, // Enable/disable based on edit mode
            ),
            SizedBox(height: 20),
            TextField(
              controller: _numberOfStudentsController,
              decoration: InputDecoration(labelText: 'Number of Students'),
              keyboardType: TextInputType.number,
              enabled: _isEditMode, // Enable/disable based on edit mode
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: null,
              enabled: _isEditMode, // Enable/disable based on edit mode
            ),
            SizedBox(height: 20),
            TextField(
              controller: _projectScopeFlagController,
              decoration: InputDecoration(labelText: 'Project Scope Flag'),
              keyboardType: TextInputType.number,
              enabled: _isEditMode, // Enable/disable based on edit mode
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isEditMode ? _handleSubmit : _toggleEditMode,
                  child: Text(_isEditMode ? 'Save' : 'Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to toggle edit mode
  void _toggleEditMode() {
    setState(() {
      _isEditMode = true;
    });
  }

  // Function to handle form submission
  Future<void> _handleSubmit() async {
    // Prepare project object
    ProjectCompany updatedProject = ProjectCompany(
      id: widget.project.id,
      title: _titleController.text,
      description: _descriptionController.text,
      numberOfStudents: int.parse(_numberOfStudentsController.text),
      projectScopeFlag: int.parse(_projectScopeFlagController.text),
    );

    // Call the patchProject function with the updated project
    await ProjectCompanyViewModel(context).patchProject(updatedProject);

    // Exit edit mode after saving
    setState(() {
      _isEditMode = false;
    });
  }
}

String _getDurationDescription(int durationIndex) {
  ProjectDuration projectDuration = ProjectDuration.values[durationIndex];

  switch (projectDuration) {
    // Switch on the enum value
    case ProjectDuration.lessThanOneMonth:
      return 'Less than 1 month';
    case ProjectDuration.oneToThreeMonths:
      return '1-3 months';
    case ProjectDuration.threeToSixMonths:
      return '3-6 months';
    case ProjectDuration.moreThanSixMonth:
      return 'More than 6 months';
  }
}
