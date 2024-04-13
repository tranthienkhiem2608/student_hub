import 'package:flutter/material.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'dart:async';

import 'package:student_hub/view_models/project_company_viewModel.dart';

class ShowProjectCompanyWidget extends StatefulWidget {
  final String projectName;
  final DateTime creationTime;
  final String description;
  final List<String> quantities;
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
      return 'Created ${diff.inSeconds} seconds ago';
    } else if (diff.inMinutes < 60) {
      return 'Created ${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      return 'Created ${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return 'Created ${diff.inDays} days ago';
    } else if (diff.inDays < 30) {
      return 'Created ${(diff.inDays / 7).round()} weeks ago';
    } else if (diff.inDays < 365) {
      return 'Created ${(diff.inDays / 30).round()} months ago';
    } else {
      return 'Created ${(diff.inDays / 365).round()} years ago';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(widget.projectName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.greenAccent)),
          subtitle: Text(timeAgo(widget.creationTime)),
          trailing: widget.showOptionsIcon
              ? IconButton(
                  icon: Icon(Icons.more_horiz_rounded),
                  onPressed: () {
                    _showOptions(context);
                  },
                )
              : null,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Students are looking for',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ListView(
                shrinkWrap: true,
                children: widget.description.split('\n').map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
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
                        Expanded(child: Text(item)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.quantities.map((quantity) {
            return Expanded(
              child: Text(
                quantity.toString(),
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.labels.map((label) {
            return Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        ),
        const Divider()
      ],
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
