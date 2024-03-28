import '../models/project_company.dart';

class ProjectCompanyViewModel {
  List<ProjectCompany> projectList = [];

  Future<void> removeProject(ProjectCompany project) async {
    // Simulate a delay for the API call
    await Future.delayed(Duration(seconds: 1));

    // Remove the project from the list
    projectList.remove(project);
  }

  Future<void> editProject(ProjectCompany oldProject, ProjectCompany newProject) async {
    // Simulate a delay for the API call
    await Future.delayed(Duration(seconds: 1));

    // Find the index of the old project in the list
    int index = projectList.indexOf(oldProject);

    // Replace the old project with the new project
    if (index != -1) {
      projectList[index] = newProject;
    }
  }
}