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
      userId: (json['user_id'] ?? 0) as int,
      type: (json['type'] ?? 0) as int,
      companyId: (json['company_id'] ?? 0) as int,
      packageId: (json['package_id'] ?? 0) as int,
      empId: (json['emp_id'] ?? 0) as int,
      empPin: (json['emp_pin'] ?? '') as String,
      moduleId: (json['module_id'] ?? 0) as int,
      ipAddress: (json['ip_address'] ?? '') as String,
      platform: (json['platform'] ?? '') as String,
      language: (json['language'] ?? '') as String,
      theme: (json['theme'] ?? '') as String,
      email: (json['email'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'type': type,
      'company_id': companyId,
      'package_id': packageId,
      'emp_id': empId,
      'emp_pin': empPin,
      'module_id': moduleId,
      'ip_address': ipAddress,
      'platform': platform,
      'language': language,
      'theme': theme,
      'email': email,
    };
  }
}
