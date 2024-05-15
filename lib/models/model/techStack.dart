class TechStack {
  final int id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String name;

  TechStack({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.name,
  });

  Map<String, dynamic> toMapTechStack() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'name': name,
    };
  }

  factory TechStack.fromMapTechStack(Map<String, dynamic> map) {
    return TechStack(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      name: map['name'],
    );
  }

  static fromListString(List<String> selectedSkills) {
    return selectedSkills.map((e) => TechStack(id: 1, name: e)).toList();
  }

  static List<TechStack> fromMapListTechStack(List<dynamic> list) {
    List<TechStack> techStackList = [];
    for (var techStack in list) {
      techStackList.add(TechStack.fromMapTechStack(techStack));
    }
    return techStackList;
  }
}
