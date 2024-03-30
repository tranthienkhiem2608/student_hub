class SkillSets{
  final String id;
  final String name;

  SkillSets({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMapSkillSets() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SkillSets.fromMapSkillSets(Map<String, dynamic> map) {
    return SkillSets(
      id: map['id'],
      name: map['name'],
    );
  }

  static fromListString(List<String> skills) {
    return skills.map((e) => SkillSets(id: e, name: e)).toList();
  }
}