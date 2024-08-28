class User {
  int id;
  String username;
  String firstname;
  String lastname;
  String credit;
  int office;
  int role;
  int department;
  String image;

  User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.credit,
    required this.office,
    required this.role,
    required this.department,
    required this.image
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['id']??0) as int,
      username: (json['username']??'') as String,
      firstname: (json['firstname']??'') as String,
      lastname: (json['lastname']??'') as String,
      credit: (json['credit']??'') as String,
      office: (json['office']??0) as int,
      role: (json['role']??0) as int,
      department: (json['department']??0) as int,
      image: (json['image']??'') as String
    );
  }
}
