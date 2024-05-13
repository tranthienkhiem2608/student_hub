import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_hub/constant/project_profile.dart';
import 'package:student_hub/models/model/company_profile.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/input_profile_viewModel.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key, required this.user});

  User user;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  CompanyProfile? _companyProfiles;

  Future<void> _getCompanyProfile() async {
    CompanyProfile data = await InputProfileViewModel(context)
        .getProfileCompany(widget.user.companyUser!.id!);
    setState(() {
      _companyProfiles = data;
    });
  }

  Future<void> _handleSubmit() async {
    CompanyProfile companyProfile = CompanyProfile(
      id: _companyProfiles?.id,
      companyName: _companyNameController.text,
      size: _selectedCompanySize!.index,
      website: _websiteController.text,
      description: _descriptionController.text,
    );
    await InputProfileViewModel(context).putProfileCompany(companyProfile);
    setState(() {
      _isEditing = false;
      _isEditingCompanySize = false;
      _getCompanyProfile();
    });
  }

  CompanySize? _selectedCompanySize;

  bool _isEditing = false;
  bool _isEditingCompanySize = false;
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _getCompanyProfile().then((_) {
      if (_companyProfiles != null) {
        _companyNameController.text = _companyProfiles!.companyName;
        _websiteController.text = _companyProfiles!.website;
        _descriptionController.text = _companyProfiles!.description;
        _selectedCompanySize = CompanySize.values[_companyProfiles!.size];
      }
    });
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
    _timer?.cancel();
    _animationController.dispose();
    _companyNameController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const _AppBar(),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                              color: Colors.black, // Màu chữ mặc định
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
                    child: TextField(
                      controller: _companyNameController,
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
                        prefixIcon: const Icon(
                          Iconsax.building,
                          color: Colors.black,
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
                        const SizedBox(
                            height: 5), // Spacing between label and TextField
                        TextField(
                          controller: _websiteController,
                          readOnly: !_isEditing,
                          cursorColor: Color(0xFF406AFF),
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.poppins(
                              // Use labelStyle if you need the label inside
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: const Icon(
                              Iconsax.link,
                              color: Colors.black,
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
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 100),
                      child: TextField(
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
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Iconsax.paperclip_2,
                              color: Colors.black,
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
                            color: Colors.black,
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
                          child: _isEditingCompanySize
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'edit_company4'.tr(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Render the radio options based on CompanySize enum
                                    Column(
                                      children: CompanySize.values.map((size) {
                                        return RadioListTile<CompanySize>(
                                          title: Text(
                                            _getSizeDescription(size
                                                .index), // Get description based on index
                                            style: GoogleFonts.poppins(
                                                fontSize: 14),
                                          ),
                                          dense: true,
                                          value: size,
                                          groupValue: _selectedCompanySize,
                                          onChanged: (CompanySize? value) {
                                            if (value != null) {
                                              setState(() {
                                                _selectedCompanySize = value;
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
                                      'edit_company3'.tr(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      _getSizeDescription(
                                          _companyProfiles?.size ?? 0),
                                      // Show current size description
                                      style: GoogleFonts.poppins(fontSize: 14),
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
                                  _isEditingCompanySize =
                                      !_isEditingCompanySize;
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

String _getSizeDescription(int sizeIndex) {
  CompanySize companySize = CompanySize.values.elementAt(sizeIndex);

  switch (companySize) {
    // Switch on the enum value
    case CompanySize.justMe:
      return 'companyprofileinput_ProfileCreation4'.tr();
    case CompanySize.small:
      return 'companyprofileinput_ProfileCreation5'.tr(); // Adjust the text as needed
    case CompanySize.medium:
      return 'companyprofileinput_ProfileCreation6'.tr(); // Adjust the text as needed
    case CompanySize.large:
      return 'companyprofileinput_ProfileCreation7'.tr(); // Adjust the text as needed
    case CompanySize.veryLarge:
      return 'companyprofileinput_ProfileCreation8'.tr(); // Adjust the text as needed
  }
}
