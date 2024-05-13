import 'package:student_hub/models/model/file_cv.dart';
import 'package:student_hub/models/model/language.dart';
import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/models/model/techStack.dart';
import 'package:student_hub/models/model/education.dart';
import 'package:student_hub/models/model/experience.dart';

class StudentUser {
  int? id;
  final String? createAt;
  final String? updatedAt;
  final String? deletedAt;
  int? userId;
  int? techStackId;
  FileCV? file;
  String? user;
  TechStack? techStack;
  List<dynamic>? proposals; // cần thêm model proposal
  List<Education>? education;
  List<Language>? languages;
  List<Experience>? experience;
  List<SkillSets>? skillSet;

  StudentUser({
    this.id,
    this.createAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.techStackId,
    this.file,
    this.user,
    this.techStack,
    this.proposals,
    this.education,
    this.languages,
    this.experience,
    this.skillSet,
  });
  Duration? get duration => experience?.fold(
        Duration.zero,
        (previousValue, element) =>
            previousValue! + element.endMonth!.difference(element.startMonth!),
      );

  Map<String, dynamic> toMapStudentUser() => {
        'id': id,
        'createAt': createAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'userId': userId,
        'techStackId': techStackId,
        'resume': file?.resume,
        'transcript': file?.transcript,
        'techStack': techStack?.toMapTechStack(),
        'proposals': proposals,
        'education': education?.map((e) => e.toMapEducation()).toList(),
        'languages': languages?.map((e) => e.toMapLanguage()).toList(),
        'experience': experience?.map((e) => e.toMapExperience()).toList(),
        'skillSets': skillSet?.map((e) => e.id).toList(),
      };

  factory StudentUser.fromMapStudentUser(Map<String, dynamic> map) {
    return StudentUser(
      id: map['id'],
      createAt: map['createAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      userId: map['userId'],
      techStackId: map['techStackId'],
      file: FileCV(
        resume: map['resume'],
        transcript: map['transcript'],
      ),
      proposals: map['proposals'],
      techStack: TechStack.fromMapTechStack(map['techStack']),
      education: List<Education>.from(
          map['educations'].map((e) => Education.fromMapEducation(e))),
      languages: List<Language>.from(
          map['languages'].map((e) => Language.fromMapLanguage(e))),
      experience: List<Experience>.from(
          map['experiences'].map((e) => Experience.fromMapExperience(e))),
      skillSet: List<SkillSets>.from(
          map['skillSets'].map((e) => SkillSets.fromMapSkillSets(e))),
    );
  }

  factory StudentUser.fromMapStudentProposal(Map<String, dynamic> map) {
    return StudentUser(
      id: map['id'],
      createAt: map['createAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      userId: map['userId'],
      techStackId: map['techStackId'],
      file: FileCV(
        resume: map['resume'],
        transcript: map['transcript'],
      ),
      user: map['user']['fullname'],
      techStack: TechStack.fromMapTechStack(map['techStack']),
      education: map['educations'] != null
          ? List<Education>.from(
              map['educations'].map((e) => Education.fromMapEducation(e)))
          : null,
      languages: map['languages'] != null
          ? List<Language>.from(
              map['languages'].map((e) => Language.fromMapLanguage(e)))
          : null,
      experience: map['experiences'] != null
          ? List<Experience>.from(
              map['experiences'].map((e) => Experience.fromMapExperience(e)))
          : null,
      skillSet: map['skillSets'] != null
          ? List<SkillSets>.from(
              map['skillSets'].map((e) => SkillSets.fromMapSkillSets(e)))
          : null,
    );
  }
  factory StudentUser.fromMapStudentProposalNotify(Map<String, dynamic> map) {
    return StudentUser(
      id: map['id'],
      createAt: map['createAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      userId: map['userId'],
      techStackId: map['techStackId'],
      file: FileCV(
        resume: map['resume'],
        transcript: map['transcript'],
      ),
      user: map['user'] == null ? null : map['user']['fullname'],
      techStack: TechStack.fromMapTechStack(map['techStack']),
      education: map['educations'] != null
          ? List<Education>.from(
              map['educations'].map((e) => Education.fromMapEducation(e)))
          : null,
      skillSet: map['skillSets'] != null
          ? List<SkillSets>.from(
              map['skillSets'].map((e) => SkillSets.fromMapSkillSets(e)))
          : null,
      languages: map['languages'] != null
          ? List<Language>.from(
              map['languages'].map((e) => Language.fromMapLanguage(e)))
          : null,
      experience: map['experiences'] != null
          ? List<Experience>.from(
              map['experiences'].map((e) => Experience.fromMapExperience(e)))
          : null,
    );
  }
}
