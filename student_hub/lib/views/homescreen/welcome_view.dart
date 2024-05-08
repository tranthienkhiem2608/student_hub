import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/views/pages/chat_screen/video_conference_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5, // Start fading in at 50% of the animation duration
          1.0, // Fully faded in at 100% of the animation duration
          curve: Curves.easeIn,
        ),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(animationController: _animationController),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: _Body(
            animationController: _animationController,
            fadeAnimation: _fadeAnimation),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant WelcomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animationController.reset();
    _animationController.forward();
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final AnimationController animationController;

  const _AppBar({super.key, required this.animationController});

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
          onPressed: () {
            ControllerRoute(context).navigateToChooseRoleView();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Body extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> fadeAnimation;

  const _Body(
      {super.key,
      required this.animationController,
      required this.fadeAnimation});

  //

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: _Content(
                animationController: animationController,
                fadeAnimation: fadeAnimation),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> fadeAnimation;

  const _Content(
      {super.key,
      required this.animationController,
      required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Animated Image
        SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(
            CurvedAnimation(
              parent: animationController,
              curve: const Interval(
                0.3,
                0.6,
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
          child: const AnimationImage(),
        ),
        // Animated Text
        SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(
            CurvedAnimation(
              parent: animationController,
              curve: const Interval(
                0.3,
                0.7,
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
          child: const _AnimatedText(),
        ),
        SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(
              0.3,
              0.8,
              curve: Curves.fastOutSlowIn,
            ),
          )),
          child: const _DescriptionText(),
        ),
        // Animated Buttons
        const SizedBox(height: 20),
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
              child: Container(
                  width: 200,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press
                      ControllerRoute(context)
                          .navigateToLoginView(); //role company
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const VideoConferencePage(
                      //           conferenceID: 'conferenceID')),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF406AFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Company',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )),
            )),
        const SizedBox(height: 10),
        SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(0, 0.5), end: const Offset(0, 0))
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
              child: Container(
                  width: 200,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press
                      ControllerRoute(context)
                          .navigateToLoginView(); //role student
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF406AFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Student',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )),
            )),
        const SizedBox(height: 50),
        SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(
              0.4,
              1,
              curve: Curves.fastOutSlowIn,
            ),
          )),
          child: const _DescriptionSecondText(),
        ),
      ],
    );
  }
}

class _AnimatedText extends StatelessWidget {
  const _AnimatedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
      child: Align(
        alignment: Alignment.center, // Change: Center alignment horizontally
        child: Text(
          "Build your product with high-skilled students",
          style: GoogleFonts.poppins(
            fontSize: 24.5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, // Also center the text itself
        ),
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          "Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF777B8A),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _DescriptionSecondText extends StatelessWidget {
  const _DescriptionSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          "StudentHub is university market place to connect high-skilled student and company on a real-world project",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(
                255, 148, 150, 155), // Use the provided hex color
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _AnimatedButton extends StatelessWidget {
  final String text;

  const _AnimatedButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Set the width to your desired size
      height: 50, // Set the height to your desired size
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}

class AnimationImage extends StatelessWidget {
  const AnimationImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          'assets/images/welcome_img.png',
        ),
      ),
    );
  }
}
