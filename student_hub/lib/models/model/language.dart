class Language {
  final int? studentId;
  final int? id;
  final String? languageName;
  final String? level;
  final String? createAt;
  final String? deletedAt;
  final String? updatedAt;

  Language({
    this.studentId,
    this.id,
    this.languageName,
    this.level,
    this.createAt,
    this.deletedAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMapLanguage() {
    return {
      'id': null,
      'languageName': languageName,
      'level': level,
    };
  }

  factory Language.fromMapLanguage(Map<String, dynamic> map) {
    return Language(
      studentId: map['studentId'],
      id: map['id'],
      languageName: map['languageName'],
      level: map['level'],
      createAt: map['createAt'],
      deletedAt: map['deletedAt'],
      updatedAt: map['updatedAt'],
    );
  }

  static fromListMap(List<Map<String, dynamic>> languages) {
    return languages.map((e) => Language.fromMapLanguage(e)).toList();
  }

  static fromListProposalLanguage(List<dynamic> languages) {
    return languages.map((e) => Language.fromMapLanguage(e)).toList();
  }
}

List<Language> langList = List.from(
  [
    Language(
      id: null,
      languageName: 'English',
      level: 'Intermediate',
    ),
    Language(
      id: null,
      languageName: 'Vietnamese',
      level: 'Native',
    ),
    Language(
      id: null,
      languageName: 'Japanese',
      level: 'Intermediate',
    ),
  ],
);
