import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/views/browse_project/project_search.dart';
import 'package:student_hub/views/browse_project/project_saved.dart';
import 'package:student_hub/widgets/project_list_widget.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<ProjectInfo> allProjects = [
    ProjectInfo(
      name: 'Create a mobile app',
      createdDate: '3 days ago',
      role: 'Senior frontend developer (Fintech)',
      duration: 'Less than 1 month',
      students: 1,
      expectations: 'Clear expectation about your project or deliverables \n'
          'Good communication skills',
      proposals: 2,
    ),
    ProjectInfo(
      name: 'Develop a website',
      createdDate: '4 days ago',
      role: 'Senior backend developer (Fintech)',
      duration: '1 to 3 months',
      students: 3,
      expectations: 'Clear expectation about your project or deliverables \n'
          'Good communication skills',
      proposals: 6,
    ),
    ProjectInfo(
      name: 'Develop a website',
      createdDate: '6 days ago',
      role: 'Senior backend developer (Fintech)',
      duration: '1 to 3 months',
      students: 5,
      expectations: 'Clear expectation about your project or deliverables \n'
          'Good communication skills',
      proposals: 5,
    ),
    ProjectInfo(
      name: 'Create a mobile app',
      createdDate: '2 days ago',
      role: 'Senior mobile developer (Fintech)',
      duration: '3 to 6 months',
      students: 3,
      expectations: 'Clear expectation about your project or deliverables \n'
          'Good communication skills',
      proposals: 2,
    ),
    ProjectInfo(
      name: 'Frontend development',
      createdDate: '1 days ago',
      role: 'Senior frontend developer (Fintech)',
      duration: 'More than 6 months',
      students: 5,
      expectations: 'Clear expectation about your project or deliverables \n'
          'Good communication skills',
      proposals: 5,
    ),
  ];

  List<ProjectInfo> filteredProjects = [];

  List<String> suggestions = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProjects.addAll(allProjects);
    suggestions = allProjects.map((project) => project.name).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterProjects(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredProjects = allProjects
            .where((project) =>
                project.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredProjects.clear();
        filteredProjects.addAll(allProjects);
      }
      updateSuggestions(
          query); // Gọi phương thức updateSuggestions để cập nhật gợi ý
    });
  }

  void updateSuggestions(String query) {
    setState(() {
      if (query.isNotEmpty) {
        Set<String> uniqueSuggestions = {};
        allProjects
            .where((project) =>
                project.name.toLowerCase().contains(query.toLowerCase()))
            .forEach((project) => uniqueSuggestions.add(project.name));
        suggestions = uniqueSuggestions.toList();
      } else {
        Set<String> uniqueSuggestions = {};
        allProjects.forEach((project) => uniqueSuggestions.add(project.name));
        suggestions = uniqueSuggestions.toList();
      }
    });
  }

  void showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for projects...',
                        hintStyle: GoogleFonts.poppins(),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          filterProjects(newValue);
                          updateSuggestions(newValue);
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    if (suggestions.isNotEmpty)
                      Container(
                        constraints: BoxConstraints(maxHeight: 300.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: suggestions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(suggestions[index]),
                              onTap: () {
                                _searchController.text = suggestions[index];
                                filterProjects(suggestions[index]);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchProject(
                                      searchResults: filteredProjects,
                                      allProjects: allProjects,
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {
                                    filteredProjects.clear();
                                    filteredProjects.addAll(allProjects);
                                  });
                                });
                              },
                            );
                          },
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 20),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        showSearchBottomSheet(context);
                      },
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Search for projects...',
                          hintStyle: GoogleFonts.poppins(),
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.bookmark_rounded),
                    color: Color.fromARGB(255, 250, 55, 87),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteProjectsPage(
                            favoriteProjects: allProjects
                                .where((project) => project.isFavorite)
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ProjectList(key: Key('allProjects'), projects: filteredProjects),
          ],
        ),
      ),
    );
  }
}
