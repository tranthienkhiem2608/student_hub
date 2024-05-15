class CompanyProfile {
  int? id;
  int? userId;
  String? email;
  String? fullname;
  final String companyName;
  final String website;
  final int size;
  final String description;

  CompanyProfile({
    this.id,
    this.userId,
    this.email,
    this.fullname,
    required this.companyName,
    required this.website,
    required this.size,
    required this.description,
  });

  Map<String, dynamic> toMapCompanyUser() => {
        'companyName': companyName,
        'size': size,
        'website': website,
        'description': description,
      };

  factory CompanyProfile.fromJson(Map<String, dynamic> json) {
    return CompanyProfile(
      id: json['id'],
      userId: json['userId'],
      email: json['email'],
      fullname: json['fullname'],
      companyName: json['companyName'],
      website: json['website'],
      size: json['size'],
      description: json['description'],
    );
  }
}
