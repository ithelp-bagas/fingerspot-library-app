class Auth {
  String token;
  UserAuth user;

  Auth({
    required this.token,
    required this.user,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> userAuthJson = json['user'] ?? {};

    UserAuth userAuth = UserAuth.fromJson(userAuthJson);
    return Auth(
      token: (json['token']??'') as String,
      user: userAuth,
    );
  }
}

class UserAuth {
  String firstname;
  String lastname;
  String username;
  String email;
  String country;
  int office;
  int role;
  int department;
  String officeName;

  UserAuth({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.country,
    required this.office,
    required this.role,
    required this.department,
    required this.officeName
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      firstname: (json['firstname']??'') as String,
      lastname: (json['lastname']??'') as String,
      username: (json['username']??'') as String,
      email: (json['email']??'') as String,
      country: (json['country']??'') as String,
      office: (json['office']??'') as int,
      role: (json['role']??'') as int,
      department: (json['department']??'') as int,
      officeName: (json['office_name'] ?? '') as String
    );
  }
}
