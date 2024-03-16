class ProjectCompany{
  final String projectName;
  final DateTime creationTime;
  final List<String> description;
  final List<int> quantities;

  ProjectCompany({
    required this.projectName,
    required this.creationTime,
    required this.description,
    required this.quantities,
  });
}