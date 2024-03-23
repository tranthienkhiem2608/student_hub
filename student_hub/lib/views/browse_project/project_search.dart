import 'package:flutter/material.dart';
import 'package:student_hub/views/browse_project/project_detail.dart';
import 'package:student_hub/widgets/project_list_widget.dart';

class SearchProject extends StatefulWidget {
  final List<ProjectInfo> searchResults;

  const SearchProject({
    Key? key,
    required this.searchResults,
    required List<ProjectInfo> allProjects,
  }) : super(key: key);

  @override
  _SearchProjectState createState() => _SearchProjectState();
}

class _SearchProjectState extends State<SearchProject> {
  String? _previousProjectLength;
  int? _previousStudentsNeeded;
  int? _previousProposalsLessThan;

  List<ProjectInfo> filteredProjects = [];
  String searchQuery = '';
  int? proposalsLessThan;
  int? studentsNeeded;
  String? projectLength;
  Map<String, bool> radioState = {
    'less_than_one_month': false,
    'one_to_three_months': false,
    'three_to_six_months': false,
    'more_than_six_months': false,
  };

  @override
  void initState() {
    super.initState();
    filteredProjects.addAll(widget.searchResults);
  }

  void navigateToProjectDetailPage(ProjectInfo project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailPage(project: project),
      ),
    );
  }

  void filterProjects() {
    setState(() {
      _previousProjectLength = projectLength;
      _previousStudentsNeeded = studentsNeeded;
      _previousProposalsLessThan = proposalsLessThan;
      filteredProjects = widget.searchResults.where((project) {
        bool passProjectLengthFilter = true;
        if (projectLength != null) {
          switch (projectLength) {
            case 'less_than_one_month':
              passProjectLengthFilter = project.duration == 'Less than 1 month';
              break;
            case 'one_to_three_months':
              passProjectLengthFilter = project.duration == '1 to 3 months';
              break;
            case 'three_to_six_months':
              passProjectLengthFilter = project.duration == '3 to 6 months';
              break;
            case 'more_than_six_months':
              passProjectLengthFilter =
                  project.duration == 'More than 6 months';
              break;
            default:
              passProjectLengthFilter = true;
          }
        }
        bool passStudentsNeededFilter = true;
        if (studentsNeeded != null) {
          passStudentsNeededFilter = project.students == studentsNeeded;
        }
        bool passProposalsLessThanFilter = true;
        if (proposalsLessThan != null) {
          passProposalsLessThanFilter = project.proposals == proposalsLessThan!;
        }
        return passProjectLengthFilter &&
            passStudentsNeededFilter &&
            passProposalsLessThanFilter;
      }).toList();
    });
  }

  void clearFilters() {
    setState(() {
      projectLength = null;
      studentsNeeded = null;
      proposalsLessThan = null;
      _previousProjectLength = null;
      _previousStudentsNeeded = null;
      _previousProposalsLessThan = null;
      filterProjects();
    });
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filter by',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 14),
                const Divider(
                  height: 5,
                  thickness: 1.5,
                  color: Color.fromARGB(255, 54, 52, 52),
                ),
                SizedBox(height: 16),
                const Text(
                  'Project length:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      children: [
                        RadioListTile(
                          title: Text('Less than one month'),
                          value: 'less_than_one_month',
                          groupValue: projectLength,
                          onChanged: (value) {
                            setState(() {
                              projectLength = value as String?;
                              radioState = {
                                'less_than_one_month':
                                    projectLength == 'less_than_one_month',
                                'one_to_three_months': false,
                                'three_to_six_months': false,
                                'more_than_six_months': false,
                              };
                            });
                          },
                          selected: radioState['less_than_one_month'] ?? false,
                        ),
                        RadioListTile(
                          title: Text('1 to 3 months'),
                          value: 'one_to_three_months',
                          groupValue: projectLength,
                          onChanged: (value) {
                            setState(() {
                              projectLength = value as String?;
                              radioState = {
                                'less_than_one_month': false,
                                'one_to_three_months':
                                    projectLength == 'one_to_three_months',
                                'three_to_six_months': false,
                                'more_than_six_months': false,
                              };
                            });
                          },
                          selected: radioState['one_to_three_months'] ?? false,
                        ),
                        RadioListTile(
                          title: Text('3 to 6 months'),
                          value: 'three_to_six_months',
                          groupValue: projectLength,
                          onChanged: (value) {
                            setState(() {
                              projectLength = value as String?;
                              radioState = {
                                'less_than_one_month': false,
                                'one_to_three_months': false,
                                'three_to_six_months':
                                    projectLength == 'three_to_six_months',
                                'more_than_six_months': false,
                              };
                            });
                          },
                          selected: radioState['three_to_six_months'] ?? false,
                        ),
                        RadioListTile(
                          title: Text('More than 6 months'),
                          value: 'more_than_six_months',
                          groupValue: projectLength,
                          onChanged: (value) {
                            setState(() {
                              projectLength = value as String?;
                              radioState = {
                                'less_than_one_month': false,
                                'one_to_three_months': false,
                                'three_to_six_months': false,
                                'more_than_six_months':
                                    projectLength == 'more_than_six_months',
                              };
                            });
                          },
                          selected: radioState['more_than_six_months'] ?? false,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16),
                const Text(
                  'Students needed:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter number of students',
                  ),
                  onChanged: (value) {
                    setState(() {
                      studentsNeeded = int.tryParse(value);
                    });
                  },
                  // Gán giá trị từ biến lưu trữ trạng thái
                  initialValue: _previousStudentsNeeded?.toString(),
                ),
                SizedBox(height: 16),
                const Text(
                  'Proposals less than:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter maximum number of proposals',
                  ),
                  onChanged: (value) {
                    setState(() {
                      proposalsLessThan = int.tryParse(value);
                    });
                  },
                  initialValue: _previousProposalsLessThan?.toString(),
                ),
                SizedBox(height: 170),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        clearFilters();
                        Navigator.pop(context); // Close bottom sheet
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Clear Filter",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        filterProjects();
                        Navigator.pop(context); // Close bottom sheet
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Apply Filter",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Student Hub',
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFBEEEF7),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                filterProjects();
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    showFilterBottomSheet(context);
                  },
                  icon: Icon(Icons.filter_list),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredProjects.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: filteredProjects.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 12,
                        thickness: 1.5,
                        color: Color.fromARGB(255, 54, 52, 52),
                      ),
                      itemBuilder: (context, index) {
                        ProjectInfo project = filteredProjects[index];

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text('Project ${project.name}'),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Created ${project.createdDate}',
                                style: TextStyle(height: 1.0),
                              ),
                              Text(
                                project.role,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\nTime: ${project.duration}, ${project.students} students needed',
                                style: TextStyle(height: 1.0),
                              ),
                              SizedBox(height: 10),
                              Text('Students are looking for'),
                              Text(
                                project.expectations.isNotEmpty
                                    ? project.expectations.split('\n').first
                                    : '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Proposals: ${project.proposals}',
                                style: TextStyle(height: 1.0),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            iconSize: 30,
                            icon: Icon(
                              project.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: project.isFavorite ? Colors.red : null,
                            ),
                            onPressed: () {
                              setState(() {
                                project.isFavorite = !project.isFavorite;
                              });
                            },
                          ),
                          onTap: () {
                            navigateToProjectDetailPage(project);
                          },
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text('No projects found.'),
                  ),
          ),
        ],
      ),
    );
  }
}
