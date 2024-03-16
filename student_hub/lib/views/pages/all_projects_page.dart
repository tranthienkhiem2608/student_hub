import 'package:flutter/material.dart';
import 'package:student_hub/views/company_proposal/hire_student_screen.dart';
import 'package:student_hub/widgets/show_project_company_widget.dart'; // Import the ShowProjectCompanyWidget

class AllProjectsPage extends StatefulWidget {
  const AllProjectsPage({super.key});
  @override
  _AllProjectsPageState createState() => _AllProjectsPageState();
}
class _AllProjectsPageState extends State<AllProjectsPage> with WidgetsBindingObserver {


  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController()..addListener(_onPageChange);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChange);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChange() {
    if (_pageController.page == _pageController.initialPage) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['Senior frontend developer (Fintech)','Senior backend developer (Fintech)','Fresher fullstack developer'];
    final List<DateTime> listTime = <DateTime>[DateTime.now(), DateTime.now(), DateTime.now()];
    const String username = "John";
    return Visibility(
      replacement: const Center(
      child: Text("\t\tWelcome, $username \nYou no have jobs"),
    ),
    visible: entries.isNotEmpty,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Expanded(
          child: ListView.separated(
            itemCount: entries.length,
            itemBuilder: (context, index)=> GestureDetector(
              onTap: () {
                // Handle your tap here.
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HireStudentScreen()));


                print('Item at index $index was tapped.');
              }, child: ShowProjectCompanyWidget(
              projectName: '${entries[index]}',
              creationTime: listTime[index],
              description:  ['Clear expectations about your project or deliverables', 'The skills required for your project', 'Details about your project'],
              quantities: [0, 8, 2],
              labels: ['Proposals', 'Messages', 'Hired'],
            ),
            ),
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ]),
    ),
    );
  }
}