class SkillSets {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;

  SkillSets({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
  });

  Map<String, dynamic> toMapSkillSets() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'name': name,
    };
  }

  factory SkillSets.fromMapSkillSets(Map<String, dynamic> map) {
    return SkillSets(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      name: map['name'],
    );
  }

  static fromListString(List<String> skills) {
    return skills.map((e) => SkillSets(id: 1, name: e)).toList();
  }

  static List<SkillSets> fromMapListSkillSets(List<dynamic> list) {
    List<SkillSets> skillSetsList = [];
    for (var skillSets in list) {
      skillSetsList.add(SkillSets.fromMapSkillSets(skillSets));
    }
    return skillSetsList;
  }
}
