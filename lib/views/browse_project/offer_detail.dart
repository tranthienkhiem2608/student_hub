import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/notification.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

import '../../../models/model/project_company.dart';

class OfferDetail extends StatefulWidget {
  const OfferDetail({super.key, required this.notifyOffer, required this.user});
  final Notify notifyOffer;
  final User user;

  @override
  State<OfferDetail> createState() => _OfferDetailState();
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
          Navigator.pop(context);
          ControllerRoute(context).navigateToHomeScreen(false, user, 3);
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
                  isDarkMode ? Colors.white : Colors.black, BlendMode.srcIn),
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

class _OfferDetailState extends State<OfferDetail>
    with SingleTickerProviderStateMixin {
  List<String> expectations = [];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
// To store the parsed expectations

  void _parseExpectations() {
    // Assuming your expectations are separated by newlines in the description
    setState(() {
      expectations =
          widget.notifyOffer.proposal!.projectCompany!.description!.split('\n');
    });
  }

  @override
  void initState() {
    super.initState();
    _parseExpectations();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.6, 1, curve: Curves.fastOutSlowIn)),
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
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
        appBar: _AppBar(user: widget.user),
        backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Expanded(
                      // Wrap the Text widget in an Expanded widget
                      child: Text(
                        'CONGRATULATIONS: ${widget.notifyOffer.content}',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${widget.notifyOffer.proposal!.projectCompany!.title}',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ListView(
                  shrinkWrap: true,
                  children: expectations.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, top: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 36),
                          Container(
                            margin: EdgeInsets.only(top: 8, right: 10),
                            width: 4,
                            height: 9,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Expanded(
                              child: Text(item,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.5,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ))),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    margin: const EdgeInsets.only(bottom: 10, right: 5),
                    width: 20, // Adjust the width for the larger icon
                    height: 20, // Adjust the height for the larger icon
                    child: Icon(
                      Icons.watch_later_outlined,
                      size: 25,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  title: Text(
                    'Project scope:',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    '${widget.notifyOffer.proposal!.projectCompany!.projectScopeFlag} months',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Container(
                    margin: const EdgeInsets.only(bottom: 10, right: 5),
                    width: 20, // Adjust the width for the larger icon
                    height: 20, // Adjust the height for the larger icon
                    child: Icon(
                      Icons.people_alt_outlined,
                      size: 25,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  title: Text(
                    'Student required:',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    '${widget.notifyOffer.proposal!.projectCompany!.numberOfStudents} students',
                    style: GoogleFonts.poppins(
                      fontSize: 15.5,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.notifyOffer.proposal!.statusFlag = 1;
                            ProposalViewModel(context).setStatusFlagProject(
                                widget.notifyOffer.proposal!);
                          });
                          ControllerRoute(context)
                              .navigateToHomeScreen(false, widget.user, 3);
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.redAccent),
                            ),
                          ),
                        ),
                        child: const Text("Refuse",
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                    ),
                    SizedBox(
                        width: 40), // Add a little space between the buttons
                    Container(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.notifyOffer.proposal!.statusFlag = 3;
                            ProposalViewModel(context).setStatusFlagProject(
                                widget.notifyOffer.proposal!);
                          });
                          // Handle send action here
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Text("Accept",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
