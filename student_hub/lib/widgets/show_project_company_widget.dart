import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';

import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/views/company_proposal/hire_student_screen.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';

class ShowProjectCompanyWidget extends StatefulWidget {
  final List<String> quantities;
  final ProjectCompany projectCompany;

  final List<String> labels;
  final bool showOptionsIcon;
  final VoidCallback? onProjectDeleted;
  final VoidCallback? onChangeStatus;
  final User? user;

  ShowProjectCompanyWidget({
    required this.quantities,
    required this.projectCompany,
    required this.labels,
    required this.showOptionsIcon,
    this.onProjectDeleted,
    this.onChangeStatus,
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
      return 'time0'.tr();
    } else if (diff.inSeconds < 60 && diff.inSeconds > 0) {
      return '${diff.inSeconds} ${'time1'.tr()}';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} ${'time2'.tr()}';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} ${'time3'.tr()}';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} ${'time4'.tr()}';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).round()} ${'time5'.tr()}';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).round()} ${'time6'.tr()}';
    } else {
      return '${(diff.inDays / 365).round()} ${'time7'.tr()}';
    }
  }

  void _toggleOptionsIcon() {
    setState(() {
      showOptionsIcon = !showOptionsIcon;
    });
  }

  void _showOptions(BuildContext context, int typeFlag) {
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
                  child: Text('companydashboard_company12'.tr(),
                      style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15)),
                ),
                onPressed: () {
                  ControllerRoute(context).navigateToTabHireStudentScreen(
                      widget.projectCompany, widget.user!, 0);
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('companydashboard_company13'.tr(),
                      style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15)),
                ),
                onPressed: () {
                  ControllerRoute(context).navigateToTabHireStudentScreen(
                      widget.projectCompany, widget.user!, 2);
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('companydashboard_company14'.tr(),
                      style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15)),
                ),
                onPressed: () {
                  ControllerRoute(context).navigateToTabHireStudentScreen(
                      widget.projectCompany, widget.user!, 3);
                },
              ),
              Divider(),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('companydashboard_company15'.tr(),
                      style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15)),
                ),
                onPressed: () {
                  ControllerRoute(context).navigateToTabHireStudentScreen(
                      widget.projectCompany, widget.user!, 1);
                },
              ),
              TextButton(
                onPressed: widget.projectCompany.typeFlag == 2
                    ? null
                    : () {
                        int typeStatus =
                            widget.projectCompany.typeFlag == 0 ? 2 : 1;
                        widget.projectCompany.typeFlag = 2;
                        widget.projectCompany.status = typeStatus;
                        // Handle start working this project
                        ProposalViewModel(context).setStartWorking(
                            widget.projectCompany, widget.user!);
                      },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.grey;
                      return isDarkMode
                          ? Colors.white
                          : Colors.black; // Use the component's default.
                    },
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('companydashboard_company19'.tr(),
                      style: GoogleFonts.poppins(
                          color: isDarkMode
                              ? widget.projectCompany.typeFlag != 2
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.4)
                              : widget.projectCompany.typeFlag != 2
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.4),
                          fontSize: 15)),
                ),
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('companydashboard_company16'.tr(),
                      style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15)),
                ),
                onPressed: () {
                  // Handle edit posting
                  ControllerRoute(context)
                      .navigateToEditProject(widget.projectCompany);
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('companydashboard_company17'.tr(),
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
                onPressed: (widget.projectCompany.typeFlag == 1 ||
                        widget.projectCompany.typeFlag == 2)
                    ? null
                    : () {
                        widget.projectCompany.typeFlag = 1;
                        // Handle start working this project
                        ProposalViewModel(context).setStartWorking(
                            widget.projectCompany, widget.user!);
                      },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.grey;
                      return Color(0xFF406AFF); // Use the component's default.
                    },
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('companydashboard_company18'.tr(),
                      style: GoogleFonts.poppins(
                          color: widget.projectCompany.typeFlag == 1
                              ? Color(0xFF406AFF).withOpacity(0.4)
                              : Color(0xFF406AFF),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;

    // Define colors based on project status
    Color statusColor;
    String statusText;
    switch (widget.projectCompany.status) {
      case 1:
        statusColor = Colors.green; // Success
        statusText = 'status2'.tr();
        break;
      case 2:
        statusColor = Colors.red; // Failed
        statusText = 'status3'.tr();
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'status4'.tr();
    }

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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 206, 250, 223),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
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
                Icon(
                  widget.projectCompany.typeFlag == 0
                      ? Icons.fiber_new_outlined
                      : widget.projectCompany.typeFlag == 1
                          ? Icons.work
                          : Icons.archive_outlined,
                  color: widget.projectCompany.typeFlag == 0
                      ? Colors.blue
                      : widget.projectCompany.typeFlag == 1
                          ? Colors.orange
                          : Colors.grey,
                  size: 30.0,
                ),
                widget.projectCompany.typeFlag == 2
                    ? () {
                        return Container(
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          constraints: const BoxConstraints(
                              minWidth: 0, maxWidth: double.infinity),
                          child: Text(
                            '$statusText',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                height: 1,
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }()
                    : () {
                        return Container();
                      }()
              ],
            ),
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
                      _showOptions(context, widget.projectCompany.typeFlag!);
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
                  'projectlist_company2'.tr(),
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
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
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
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

void _confirmProjectStatus(
    BuildContext context, ShowProjectCompanyWidget widget) {
  bool isDarkMode =
      Provider.of<DarkModeProvider>(context, listen: false).isDarkMode;

  int? selectedStatus; // Variable to store the selected status

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            title: Text('Project Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<int>(
                  hint: Text('Select Project Status'),
                  value: selectedStatus,
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Success'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('Failed'),
                    ),
                  ],
                  onChanged: (int? value) {
                    setState(() {
                      selectedStatus = value; // Update the selected status
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: selectedStatus != null
                    ? () {
                        // Update project status here
                        widget.projectCompany.status = selectedStatus!;
                        widget.projectCompany.typeFlag = 2;
                        ProposalViewModel(context).setStartWorking(
                            widget.projectCompany, widget.user!);
                        Navigator.of(context).pop(); // Close dialog

                        // Show Success alert
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content:
                                  Text('Project status updated successfully'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // Call onChangeStatus callback
                                    if (widget.onChangeStatus != null) {
                                      widget.onChangeStatus!();
                                    }
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    : null,
                child: Text('Confirm'),
              ),
            ],
          );
        },
      );
    },
  );
}

void _confirmDeletion(BuildContext context, ShowProjectCompanyWidget widget) {
  Navigator.of(context).pop(); // Close bottom sheet first

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('companydashboard_company20'.tr()),
        content: Text('companydashboard_company21'.tr()),
        actions: [
          TextButton(
            child: Text('companyprofileedit_ProfileCreation2'.tr(),
                style: TextStyle(color: Colors.grey)),
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
          ),
          TextButton(
            child: Text('companyprofileedit_ProfileCreation3'.tr(),
                style: TextStyle(color: Colors.red)),
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
                    SnackBar(content: Text('companydashboard_company22'.tr())));
              });
            },
          ),
        ],
      );
    },
  );
}
