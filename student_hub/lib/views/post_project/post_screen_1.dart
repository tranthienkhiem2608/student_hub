import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_hub/views/post_project/post_screen_2.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PostScreen1 extends HookWidget {
  const PostScreen1({super.key});

  @override
  Widget build(BuildContext context) {
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
        appBar: const _AppBar(),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "1/4 Let's start with a strong title",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "This helps your post stand out to the right students. It's the first thing they'll see, so make it impressive!",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
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
                  height: 20,
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
                    child: TextField(
                      onChanged: (value) {
                        projectName.value = value;
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        labelText: 'Title Name',
                        hintText: 'Your Title Name!',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        prefixIcon: const Icon(
                          Iconsax.paperclip_2,
                          color: Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
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
                    parent: animationController,
                    curve: const Interval(
                      0.3,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Example title",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                              text: const TextSpan(
                                style: TextStyle(
                                  // Style for overall text
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                children: [
                                  TextSpan(text: "• "), // Bullet point
                                  TextSpan(
                                    text:
                                        "Build responsive WordPress site with booking/payment functionality",
                                  ),
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
                  height: 20,
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
                              text: const TextSpan(
                                style: TextStyle(
                                  // Style for overall text
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                children: [
                                  TextSpan(text: "• "), // Bullet point
                                  TextSpan(
                                    text:
                                        "Facebook ad specialist need for product launch",
                                  ),
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
                  height: 20,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostScreen2(projectName: projectName.value),
                              ),
                            );
                          },
                          height: 55,
                          color: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Text(
                            "Next: Scope",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
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
