class FileCV {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? userId;
  int? techStackId;
  String? resume;
  String? transcript;

  FileCV({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.techStackId,
    this.resume,
    this.transcript,
  });

  

  Map<String, dynamic> toMapFileResume() {
    return {
      'id': null,
      'resume': resume,
    };
  }

  Map<String, dynamic> toMapFileTranscript() {
    return {
      'id': null,
      'transcript': transcript,
    };
  }

  factory FileCV.fromMapFileCV(Map<String, dynamic> map) {
    return FileCV(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      userId: map['userId'],
      techStackId: map['techStackId'],
      resume: map['resume'],
      transcript: map['transcript'],
    );
  }

  static fromListMap(List<Map<String, dynamic>> fileCVs) {
    return fileCVs.map((e) => FileCV.fromMapFileCV(e)).toList();
  }
}
