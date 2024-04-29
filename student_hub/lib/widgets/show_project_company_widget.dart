import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';

import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';

class ShowProjectCompanyWidget extends StatefulWidget {
  final List<String> quantities;
  final ProjectCompany projectCompany;

  final List<String> labels;
  final bool showOptionsIcon;
  final VoidCallback? onProjectDeleted;
  final User? user;

  ShowProjectCompanyWidget({
    required this.quantities,
    required this.projectCompany,
    required this.labels,
    required this.showOptionsIcon,
    this.onProjectDeleted,
    this.user,
  });

  @override
  _ShowProjectCompanyWidgetState createState() =>
      _ShowProjectCompanyWidgetState();
}

class _ShowProjectCompanyWidgetState extends State<ShowProjectCompanyWidget> {
  bool showOptionsIcon = true;

  String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inSeconds <= 0) {
      return 'Just now';
    } else if (diff.inSeconds < 60 && diff.inSeconds > 0) {
      return '${diff.inSeconds} seconds ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).round()} weeks ago';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).round()} months ago';
    } else {
      return '${(diff.inDays / 365).round()} years ago';
    }
  }

  void _toggleOptionsIcon() {
    setState(() {
      showOptionsIcon = !showOptionsIcon;
    });
  }

  void _showOptions(BuildContext context) {
    bool isDarkMode =
        Provider.of<DarkModeProvider>(context, listen: false).isDarkMode;
    showModalBottomSheet(
        backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('View proposals',
                      style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15)),
                ),
                onPressed: () {
                  // Handle view proposals
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('View messages',
                      style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15)),
                ),
                onPressed: () {
                  // Handle view messages
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('View hired',
                      style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15)),
                ),
                onPressed: () {
                  // Handle view hired
                },
              ),
              Divider(),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('View job posting',
                      style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15)),
                ),
                onPressed: () {
                  // Handle view job posting
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Edit posting',
                      style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15)),
                ),
                onPressed: () {
                  // Handle edit posting
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Remove posting',
                      style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 250, 55, 87),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
                onPressed: () {
                  _confirmDeletion(context, widget);
                },
              ),
              Divider(),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Start working this project',
                      style: GoogleFonts.poppins(
                          color: Color(0xFF406AFF),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
                onPressed: () {
                  widget.projectCompany.typeFlag = 1;
                  // Handle start working this project
                  ProposalViewModel(context)
                      .setStartWorking(widget.projectCompany, widget.user!);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2f2f2f) : Colors.white,
        border: Border.all(
          color: isDarkMode
              ? Color.fromARGB(255, 60, 60, 60)
              : Color.fromARGB(255, 228, 228, 233),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color:
                isDarkMode ? Color(0xFF212121) : Colors.grey.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 206, 250, 223),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.fromLTRB(0, 0, 180, 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                constraints: const BoxConstraints(
                    minWidth: 0, maxWidth: double.infinity),
                child: Text(
                  timeAgo(DateTime.parse(
                      widget.projectCompany.createdAt!.toString())),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      height: 1,
                      fontSize: 11,
                      color: Color.fromARGB(255, 18, 119, 52),
                      fontWeight: FontWeight.w500),
                )),
            subtitle: Text(widget.projectCompany.title!,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF406AFF),
                )),
            trailing: widget.showOptionsIcon
                ? IconButton(
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    padding: EdgeInsets.only(bottom: 35),
                    onPressed: () {
                      _showOptions(context);
                    },
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 10, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Students are looking for: ',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: widget.projectCompany.description!
                      .split('\n')
                      .map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 0, top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(item,
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ))),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.quantities.map((quantity) {
              return Expanded(
                child: Text(quantity.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.w500, color: isDarkMode ? Colors.white : Colors.black,)),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.labels.map((label) {
              return Expanded(
                child: Text(label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w500, color: isDarkMode ? Colors.white : Colors.black,)),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

void _confirmDeletion(BuildContext context, ShowProjectCompanyWidget widget) {
  Navigator.of(context).pop(); // Close bottom sheet first

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this project?'),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
          ),
          TextButton(
            child: Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              ProjectCompanyViewModel(context)
                  .deleteProject(widget.projectCompany.id!)
                  .then((value) {
                Navigator.of(context).pop(); // Close dialog
                if (widget.onProjectDeleted != null) {
                  widget
                      .onProjectDeleted!(); // Trigger project deleted callback
                }
              }).catchError((error) {
                Navigator.of(context).pop(); // Close dialog even on error
                print('Error deleting project: $error');

                // Show Error Message (Here's one way using a snackbar):
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting project.')));
              });
            },
          ),
        ],
      );
    },
  );
}
