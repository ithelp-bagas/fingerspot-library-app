class Pwa {
  int userId;
  int type;
  int companyId;
  int packageId;
  int empId;
  String empPin;
  int moduleId;
  String ipAddress;
  String platform;
  String language;
  String theme;
  String email;

  Pwa({
    required this.userId,
    required this.type,
    required this.companyId,
    required this.packageId,
    required this.empId,
    required this.empPin,
    required this.moduleId,
    required this.ipAddress,
    required this.platform,
    required this.language,
    required this.theme,
    required this.email,
  });

  factory Pwa.fromJson(Map<String, dynamic> json) {
    return Pwa(
      userId: (json['userId'] ?? 0) as int,
      type: (json['type'] ?? 0) as int,
      companyId: (json['companyId'] ?? 0) as int,
      packageId: (json['packageId'] ?? 0) as int,
      empId: (json['empId'] ?? 0) as int,
      empPin: (json['empPin'] ?? '') as String,
      moduleId: (json['moduleId'] ?? 0) as int,
      ipAddress: (json['userId'] ?? '') as String,
      platform: (json['platform'] ?? '') as String,
      language: (json['language'] ?? '') as String,
      theme: (json['theme'] ?? '') as String,
      email: (json['email'] ?? '') as String,
    );
  }

}
