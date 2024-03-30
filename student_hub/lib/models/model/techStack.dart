class TechStack{
  final String id;
  final String name;


  TechStack({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMapTechStack() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory TechStack.fromMapTechStack(Map<String, dynamic> map) {
    return TechStack(
      id: map['id'],
      name: map['name'],
    );
  }

  static fromListString(List<String> selectedSkills) {
    return selectedSkills.map((e) => TechStack(id: e, name: e)).toList();
  }
}