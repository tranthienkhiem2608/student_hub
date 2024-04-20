import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/project_company.dart';
import 'package:student_hub/widgets/show_project_company_widget.dart';

class AllProjectsPageStudent extends StatefulWidget {
  final User user;
  final Future<List<Proposal>> Function() fetchProjectDataFunction;
  const AllProjectsPageStudent(
      {super.key, required this.user, required this.fetchProjectDataFunction});
  @override
  _AllProjectsPageStudentState createState() => _AllProjectsPageStudentState();
}

class _AllProjectsPageStudentState extends State<AllProjectsPageStudent>
    with WidgetsBindingObserver {
  late final PageController _pageController;
  late Future<List<Proposal>> futureProjects;

  @override
  void initState() {
    super.initState();
    _pageController = PageController()..addListener(_onPageChange);
    setState(() {
      futureProjects = widget.fetchProjectDataFunction();
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChange);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChange() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.page == _pageController.initialPage) {
        if (mounted) {
          setState(() {
            futureProjects = widget.fetchProjectDataFunction();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Text(
            "Active Proposal (0)",
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          // Thêm Expanded ở đây
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 0)),
                Expanded(
                  child: FutureBuilder<List<Proposal>>(
                    future: futureProjects,
                    builder: (context, proposal) {
                      if (proposal.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (proposal.hasError) {
                        return Text('Error: ${proposal.error}');
                      } else if (proposal.hasData && proposal.data!.isEmpty) {
                        return const Center(
                            child: Text(
                                "\t\tYou no have active proposal yet. Please check back later."));
                      } else {
                        return ListView.builder(
                          itemCount: proposal.data!.length,
                          itemBuilder: (context, index) {
                            Proposal proposalItem = proposal.data![index];
                            print(proposalItem.projectCompany!.title);
                            print(proposalItem.projectCompany!.description);
                            if (proposalItem.statusFlag != 1) {
                              return const SizedBox.shrink();
                            }
                            return GestureDetector(
                              onTap: () {},
                              child: ShowProjectCompanyWidget(
                                projectCompany: proposalItem.projectCompany!,
                                quantities: const [],
                                labels: const [],
                                showOptionsIcon: false,
                                onProjectDeleted: () {},
                                user: widget.user,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Text(
            "Submitted proposal (0)",
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          // Thêm Expanded ở đây
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 0)),
                Expanded(
                  child: FutureBuilder<List<Proposal>>(
                    future: futureProjects,
                    builder: (context, proposal) {
                      if (proposal.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (proposal.hasError) {
                        return Text('Error: ${proposal.error}');
                      } else if (proposal.hasData && proposal.data!.isEmpty) {
                        return const Center(
                            child: Text(
                                "\t\tYou no have active proposal yet. Please check back later."));
                      } else {
                        return ListView.builder(
                          itemCount: proposal.data!.length,
                          itemBuilder: (context, index) {
                            Proposal proposalItem = proposal.data![index];
                            print(proposalItem.projectCompany!.title);
                            print(proposalItem.projectCompany!.description);
                            if (proposalItem.statusFlag != 0) {
                              return const SizedBox.shrink();
                            }
                            return GestureDetector(
                              onTap: () {},
                              child: ShowProjectCompanyWidget(
                                projectCompany: proposalItem.projectCompany!,
                                quantities: const [],
                                labels: const [],
                                showOptionsIcon: false,
                                onProjectDeleted: () {},
                                user: widget.user,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
