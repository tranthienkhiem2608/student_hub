import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'dart:async';

import 'package:student_hub/view_models/project_company_viewModel.dart';

class ShowProjectCompanyWidget extends StatefulWidget {
  final String projectName;
  final DateTime creationTime;
  final String description;
  final List<int> quantities;
  final List<String> labels;
  final bool showOptionsIcon;
  final int id;
  final VoidCallback? onProjectDeleted;

  ShowProjectCompanyWidget({
    required this.projectName,
    required this.creationTime,
    required this.description,
    required this.quantities,
    required this.labels,
    required this.showOptionsIcon,
    required this.id,
    this.onProjectDeleted,
  });

  @override
  _ShowProjectCompanyWidgetState createState() =>
      _ShowProjectCompanyWidgetState();
}

class _ShowProjectCompanyWidgetState extends State<ShowProjectCompanyWidget> {
  bool showOptionsIcon = true;

  String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inSeconds < 60) {
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
    showModalBottomSheet(
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
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('View proposals',
                      style: TextStyle(color: Colors.black)),
                ),
                onPressed: () {
                  // Handle view proposals
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('View messages',
                      style: TextStyle(color: Colors.black)),
                ),
                onPressed: () {
                  // Handle view messages
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Text('View hired', style: TextStyle(color: Colors.black)),
                ),
                onPressed: () {
                  // Handle view hired
                },
              ),
              Divider(),
              TextButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('View job posting',
                      style: TextStyle(color: Colors.black)),
                ),
                onPressed: () {
                  // Handle view job posting
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Edit posting',
                      style: TextStyle(color: Colors.black)),
                ),
                onPressed: () {
                  // Handle edit posting
                },
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Remove posting',
                      style: TextStyle(color: Colors.black)),
                ),
                onPressed: () {
                  _confirmDeletion(context, widget);
                },
              ),
              Divider(),
              TextButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Start working this project',
                      style: TextStyle(color: Colors.black)),
                ),
                onPressed: () {
                  // Handle start working this project
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color.fromARGB(255, 220, 220, 247),
          width: 1, // Màu và độ dày của border
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(244, 194, 207, 252).withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 9),
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
                  timeAgo(widget.creationTime),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      height: 1,
                      fontSize: 11,
                      color: Color.fromARGB(255, 18, 119, 52),
                      fontWeight: FontWeight.w500),
                )),
            subtitle: Text(widget.projectName,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF406AFF),
                )),
            trailing: widget.showOptionsIcon
                ? IconButton(
                    icon: Icon(Icons.more_horiz_rounded),
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
                Text('Students are looking for',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ListView(
                  shrinkWrap: true,
                  children: widget.description.split('\n').map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 0, top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(item, style: GoogleFonts.poppins())),
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
                child: Text(
                  quantity.toString(),
                  textAlign: TextAlign.center,
                   style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)
                ),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.labels.map((label) {
              return Expanded(
                child: Text(label,
                    textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
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
                  .deleteProject(widget.id)
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
