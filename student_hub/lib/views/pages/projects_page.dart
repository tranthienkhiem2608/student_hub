import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:student_hub/views/browse_project/project_search.dart';
import 'package:student_hub/views/browse_project/project_saved.dart';
import 'package:student_hub/widgets/project_list_widget.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ProjectsPage extends StatefulWidget {
  final User? user;
  const ProjectsPage(this.user, {super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late Future<List<ProjectCompany>> allProjects;
  List<ProjectCompany> projectsList = [];
  List<ProjectCompany> filteredProjects = [];
  List<String> suggestions = [];
  static const int itemsPerPage = 10;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  final scrollController = ScrollController();

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _initializeData();
    setState(() {
      allProjects =
          fetchAllProjects(currentPage, itemsPerPage, null, null, null, null);
    });
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            setState(() {
              // Your state change here
              loadMoreData();
            });
          });
        }
      }
    });
  }

  void loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      List<ProjectCompany> newProjects = await fetchAllProjects(
          ++currentPage, itemsPerPage, null, null, null, null);

      // Fetch the next page of data

      print('Current Page: $currentPage');
      // Update the state with the new data
      setState(() {
        isLoading = false;
        projectsList.addAll(newProjects);
        print('Current Page: $currentPage');
        hasMoreData = newProjects.length == itemsPerPage;
      });
    }
  }

  Future<void> _initializeData() async {
    List<ProjectCompany> projects = await fetchAllProjects(
        currentPage, itemsPerPage, null, null, null, null);
    setState(() {
      // Assuming you're using this in a StatefulWidget
      if(mounted){
      suggestions = projects.map((project) => project.title!).toList();

      }
    });
  }

  // void filterProjects(String query) async {
  //   final projects = await fetchAllProjects(
  //       currentPage, itemsPerPage, null, null, null, null);
  //   setState(() {
  //     if (query.isNotEmpty) {
  //       filteredProjects = projects
  //           .where((project) =>
  //               project.title!.toLowerCase().contains(query.toLowerCase()))
  //           .toList();
  //     } else {
  //       filteredProjects = projects;
  //     }
  //     updateSuggestions(query);
  //   });
  // }

  void updateSuggestions(String query) async {
    final projects = await fetchAllProjects(
        currentPage, itemsPerPage, null, null, null, null);
    setState(() {
      if (query.isNotEmpty) {
        final uniqueSuggestions = projects
            .where((project) =>
                project.title!.toLowerCase().contains(query.toLowerCase()))
            .map((project) => project.title!)
            .toSet();
        suggestions = uniqueSuggestions.toList();
      } else {
        suggestions = projects.map((project) => project.title!).toList();
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

                        hintText: 'projectlist_project2'.tr(),
                        
                        hintStyle: GoogleFonts.poppins(),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onChanged: (newValue) {},
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
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchProject(
                                      searchResults: filteredProjects,
                                      user: widget.user!,
                                    ),
                                  ),
                                ).then((value) {
                                  _initializeData();
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
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 20),
          child: Container(
            padding: EdgeInsets.only(top: 15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.white
                              : Colors.black, // Choose your border color
                          width: 1.0, // Choose the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            50.0), // Adjust the border radius as needed
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (newValue) {
                          _searchController.text = newValue;
                        },
                        onSubmitted: (value) {
                          print('Search for: $filteredProjects');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchProject(
                                searchResults: filteredProjects,
                                user: widget.user!,
                                searchQuery: _searchController.text,
                              ),
                            ),
                          ).then((value) {
                            _initializeData();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'projectlist_project2'.tr(),
                          hintStyle: GoogleFonts.poppins(
                            color: isDarkMode
                                ? Color.fromARGB(255, 98, 98, 98)
                                : Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          border: InputBorder
                              .none, // Remove default border of TextField
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder<int>(
                    future: SharedPreferences.getInstance()
                        .then((prefs) => prefs.getInt('role') ?? 0),
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData && snapshot.data == 0) {
                          return IconButton(
                            icon: Icon(Icons.bookmark_rounded),
                            color: Color.fromARGB(255, 250, 55, 87),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FavoriteProjectsPage(
                                    favoriteProjects: filteredProjects
                                        .where((project) => project.isFavorite)
                                        .toList(),
                                    studentId: widget.user!.studentUser!.id!,
                                    user: widget.user!,
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return SizedBox
                              .shrink(); // Return an empty widget if role is not 0
                        }
                      } else {
                        return CircularProgressIndicator(); // Show a loading spinner while waiting for the future to complete
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<ProjectCompany>>(
          future: allProjects,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              projectsList = snapshot.data!;
              return TabBarView(
                children: [
                  ProjectList(
                    key: Key('allProjects'),
                    projects: projectsList,
                    user: widget.user!,
                    fetchAllProjects: fetchAllProjects,
                    scrollController: scrollController,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<ProjectCompany>> fetchAllProjects(
      int currentPage,
      int itemsPerPage,
      String? title,
      String? projectScopeFlag,
      String? numberOfStudents,
      String? proposalsLessThan) async {
    List<ProjectCompany> projectTmp = await ProjectCompanyViewModel(context)
        .getAllProjectsData(currentPage, itemsPerPage, title, projectScopeFlag,
            numberOfStudents, proposalsLessThan);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('role') == 1) {
      return projectTmp;
    }
    List<Proposal> proposals = await ProposalViewModel(context)
        .getProposalById(widget.user!.studentUser!.id!);
    //check if projectId have in proposal will remove from project list
    projectTmp.removeWhere((project) =>
        proposals.any((proposal) => proposal.projectId == project.id));
    return projectTmp;
  }
}
