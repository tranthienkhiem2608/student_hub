class CompanyUser {
  final int? id;
  final String? createAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? userID;
  final String? companyName;
  int? size;
  final String? website;
  final String? description;

  CompanyUser({
    this.id,
    this.createAt,
    this.updatedAt,
    this.deletedAt,
    this.userID,
    this.companyName,
    this.size,
    this.website,
    this.description,
  });

  Map<String, dynamic> toMapCompanyUser() => {
        'companyName': companyName,
        'size': size,
        'website': website,
        'description': description,
      };

  factory CompanyUser.fromMapCompanyUser(Map<String, dynamic> map) {
    return CompanyUser(
      id: map['id'],
      createAt: map['createAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      userID: map['userID'],
      companyName: map['companyName'],
      size: map['size'],
      website: map['website'],
      description: map['description'],
    );
  }

  toMapCompany() {}
}
