import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/views/post_project/post_screen_2.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class PostScreen1 extends HookWidget {
  const PostScreen1(this.user, {super.key});
  final User? user;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    final projectName = useState('');
    final activeIndex = useState(0);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    );

    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.3, 0.8, curve: Curves.easeIn)),
    );

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 4), (timer) {
        activeIndex.value = (activeIndex.value + 1) % 4;
      });

      animationController.forward();

      return () {
        timer.cancel();
        animationController.dispose();
      };
    }, []);

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
        appBar: AppBar(
          leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: isDarkMode ? Colors.white : Color(0xFF242526),
          onPressed: () {
            Navigator.pop(context);
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
          actions: <Widget>[
            IconButton(
              icon: Container(
                // Add a Container as the parent
                padding: const EdgeInsets.all(8.0), // Padding for spacing
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      isDarkMode ? Colors.white : Colors.black,
                      BlendMode.srcIn),
                  child: Image.asset('assets/icons/user_ic.png',
                      width: 25, height: 25),
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 0),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                    parent: animationController,
                    curve: const Interval(0.3, 1, curve: Curves.fastOutSlowIn),
                  )),
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: 'projectpost1_project1'.tr(),
                                style: GoogleFonts.poppins(
                                    color: Color(
                                        0xFF406AFF)), // Thay đổi màu cho phần này
                              ),
                              TextSpan(
                                text: "projectpost1_project2".tr(),
                                style: GoogleFonts.poppins(
                                  color: isDarkMode ? Colors.white : Colors.black,
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.5),
                      end: const Offset(0, 0),
                    ).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: const Interval(
                          0.3,
                          1,
                          curve: Curves.fastOutSlowIn,
                        ),
                      ),
                    ),
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "projectpost1_project3".tr(),
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? const Color.fromARGB(255, 209, 209, 209) : Color.fromARGB(255, 103, 107, 119),
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(
                        0.3,
                        1,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                  ),
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: TextField(
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onChanged: (value) {
                        projectName.value = value;
                      },
                      cursorColor: Color(0xFF406AFF),
                      minLines: 5, // Đặt số dòng tối thiểu
                      maxLines: null, // Đặt số dòng tối đa là không giới hạn
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0), // Điều chỉnh khoảng cách nội dung
                        hintText: 'projectpost1_project5'.tr(),

                        hintStyle: GoogleFonts.poppins(
                          color: isDarkMode ? Color.fromARGB(255, 171, 171, 171) : Colors.grey,
                          fontSize: 15.0,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 95.0),
                          child: Icon(
                            Iconsax.paperclip_2,
                            color: isDarkMode ? Colors.white : Colors.black,
                            size: 18,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF777B8A), width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF777B8A), width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                    parent: animationController,
                    curve: const Interval(
                      0.3,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "projectpost1_project6".tr(),
                          style: GoogleFonts.poppins(
                            color: Color(0xFF406AFF),
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0, -0.5),
                            end: const Offset(0, 0))
                        .animate(CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(
                        0.3,
                        1,
                        curve: Curves.fastOutSlowIn,
                      ),
                    )),
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align to the top
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  // Style for overall text
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                children: [
                                  TextSpan(text: "• ", style: GoogleFonts.poppins(color: isDarkMode ? Colors.white : Colors.black,)), // Bullet point
                                  TextSpan(
                                      text:
                                          "projectpost1_project7".tr(),
                                      style: GoogleFonts.poppins(fontSize: 15, color: isDarkMode ? Colors.white : Colors.black,)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0, -0.5),
                            end: const Offset(0, 0))
                        .animate(CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(
                        0.3,
                        1,
                        curve: Curves.fastOutSlowIn,
                      ),
                    )),
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align to the top
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  // Style for overall text
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                children: [
                                  TextSpan(text: "• ", style: GoogleFonts.poppins(color: isDarkMode ? Colors.white : Colors.black,)), // Bullet point
                                  TextSpan(
                                      text:
                                          "projectpost1_project8".tr(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: isDarkMode ? Colors.white : Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                    parent: animationController,
                    curve: const Interval(0.6, 1, curve: Curves.fastOutSlowIn),
                  )),
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end, // Align right
                      children: [
                        const Spacer(),
                        MaterialButton(
                          onPressed: () {
                            ProjectCompany project = ProjectCompany(
                              title: projectName.value,
                              companyId: user!.companyUser?.id!.toString(),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostScreen2(
                                  project: project,
                                  user: user!,
                                ),
                              ),
                            );
                          },
                          height: 55,
                          color: Color(0xFF406AFF),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            "projectpost1_project9".tr(),
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
