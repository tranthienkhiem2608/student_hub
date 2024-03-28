class ProjectScope{
  final String id;
  final String range;

  ProjectScope({
    required this.id,
    required this.range,
  });

  Map<String, dynamic> toMapProjectScope() {
    return {
      'id': id,
      'range': range,
    };
  }

  factory ProjectScope.fromMapProjectScope(Map<String, dynamic> map) {
    return ProjectScope(
      id: map['id'],
      range: map['range'],
    );
  }
}