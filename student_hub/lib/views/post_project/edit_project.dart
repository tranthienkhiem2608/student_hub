import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/view_models/project_company_viewModel.dart';

class EditProject extends StatefulWidget {
  EditProject({Key? key, required this.project, required this.user})
      : super(key: key);

  final ProjectCompany project;
  final User user;

  @override
  _EditProjectState createState() => _EditProjectState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: isDarkMode ? Colors.white : Color(0xFF242526),
        onPressed: () {
          ControllerRoute(context).navigateToHomeScreen(false, user, 1);
        },
      ),
      title: Text('Student Hub',
          style: GoogleFonts.poppins(
              // Apply the Poppins font
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      backgroundColor:
          isDarkMode ? Color.fromARGB(255, 28, 28, 29) : Colors.white,
      actions: <Widget>[],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _EditProjectState extends State<EditProject>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  Future<void> _handleSubmit() async {
    ProjectCompany updatedProject = ProjectCompany(
        id: widget.project.id,
        title: _titleController.text,
        description: _descriptionController.text,
        numberOfStudents: int.parse(_numberOfStudentsController.text),
        projectScopeFlag: _selectedProjectDuration?.index);

    // Call the patchProject function with the updated project
    await ProjectCompanyViewModel(context).patchProject(updatedProject);
    setState(() {
      _isEditing = false;
      _isEditingProjectDuration = false;
      Navigator.pop(context);
      ControllerRoute(context).navigateToHomeScreen(false, widget.user, 1);
    });
  }

  ProjectDuration? _selectedProjectDuration;

  bool _isEditing = false;
  bool _isEditingProjectDuration = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _numberOfStudentsController =
      TextEditingController();
  final TextEditingController _projectScopeFlagController =
      TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.project.title!;
    _descriptionController.text = widget.project.description!;
    _numberOfStudentsController.text =
        widget.project.numberOfStudents.toString();
    _projectScopeFlagController.text =
        widget.project.projectScopeFlag.toString();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          activeIndex++;

          if (activeIndex == 4) {
            activeIndex = 0;
          }
        });
      }
    });

    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.3, // Start fading in at 50% of the animation duration
          0.8, // Fully faded in at 100% of the animation duration
          curve: Curves.easeIn,
        ),
      ),
    );
    _animationController.forward();
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
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
        appBar: _AppBar(user: widget.user),
        backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 0,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(
                      0.3,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.black, // Màu chữ mặc định
                            ),
                            children: [
                              TextSpan(
                                text: "edit_company1".tr(),
                              ),
                              TextSpan(
                                text: "edit_company2".tr(),
                                style: GoogleFonts.poppins(
                                    color: Color(
                                        0xFF406AFF)), // Màu chữ của "Student Hub"
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(
                      0.3,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Title',
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      TextField(
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        controller: _titleController,
                        readOnly: !_isEditing,
                        cursorColor: Color(0xFF406AFF),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          labelStyle: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          hintStyle: GoogleFonts.poppins(
                            color: Color(0xFF777B8A),
                            fontSize: 13.5,
                          ),
                          prefixIcon: Icon(
                            Iconsax.building,
                            color: isDarkMode ? Colors.white : Colors.black,
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF4BEC0C7), width: 0.8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          floatingLabelStyle: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF4BEC0C7), width: 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(0.3, 1,
                              curve: Curves.fastOutSlowIn))),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      // Add a Column to hold both the label and input field
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          'Number of Students',
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ), // Spacing between label and TextField
                        TextField(
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          controller: _numberOfStudentsController,
                          readOnly: !_isEditing,
                          cursorColor: Color(0xFF406AFF),
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.poppins(
                              // Use labelStyle if you need the label inside
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: Icon(
                              Iconsax.link,
                              color: isDarkMode ? Colors.white : Colors.black,
                              size: 18,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF4BEC0C7), width: 0.8),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            floatingLabelStyle: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF4BEC0C7), width: 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -0.5),
                    end: const Offset(0, 0),
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(
                        0.3,
                        1,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Description',
                            style: GoogleFonts.poppins(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 100),
                          child: TextField(
                            style: GoogleFonts.poppins(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            controller: _descriptionController,
                            readOnly: !_isEditing,
                            cursorColor: Color(0xFF406AFF),
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              labelStyle: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                              hintStyle: GoogleFonts.poppins(
                                color: Color(0xFF777B8A),
                                fontSize: 14.0,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Iconsax.paperclip_2,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  size: 18,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF4BEC0C7),
                                  width: 0.8,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              floatingLabelStyle: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 254, 254, 254),
                                fontSize: 18.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF4BEC0C7),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -0.5),
                          end: const Offset(0, 0),
                        ).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(
                              0.3, // Start sliding in at 30% of the animation duration
                              1, // Fully slid in at 100% of the animation duration
                              curve: Curves.fastOutSlowIn,
                            ),
                          ),
                        ),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: _isEditingProjectDuration
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Project Duration',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Render the radio options based on ProjectDuration enum
                                    Column(
                                      children:
                                          ProjectDuration.values.map((size) {
                                        return RadioListTile<ProjectDuration>(
                                          title: Text(
                                            _getDurationDescription(size
                                                .index), // Show the size description
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          dense: true,
                                          value: size,
                                          groupValue: _selectedProjectDuration,
                                          onChanged: (ProjectDuration? value) {
                                            if (value != null) {
                                              setState(() {
                                                _selectedProjectDuration =
                                                    value; // Update the selected value
                                              });
                                            }
                                          },
                                          activeColor: Color(0xFF406AFF),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Current Project Duration',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      _getDurationDescription(
                                          widget.project.projectScopeFlag ?? 0),
                                      // Show current size description
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Đặt nút ở phía bên phải
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(0, -0.5),
                                  end: const Offset(0, 0))
                              .animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(
                                0.3,
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  _isEditing = !_isEditing;
                                  _isEditingProjectDuration =
                                      !_isEditingProjectDuration;
                                });
                              },
                              height: 45,
                              color: Color(0xFF4DBE3FF),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "edit_company5".tr(),
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF406AFF), fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(0, -0.5),
                                  end: const Offset(0, 0))
                              .animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(
                                0.3,
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: MaterialButton(
                              onPressed: _handleSubmit,
                              height: 45,
                              color: Color(0xFF406AFF),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "edit_company6".tr(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
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
