import 'package:fingerspot_library_app/models/post_model.dart';

class Profile {
  int id;
  String username;
  String image;
  String firstname;
  String lastname;
  String skills;
  String email;
  String credit;
  List<Post> posts;
  int postTotal;
  int topicTotal;
  String departmentName;
  String officeName;
  String roleName;

  Profile({
    required this.id,
    required this.image,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.skills,
    required this.email,
    required this.credit,
    required this.posts,
    required this.postTotal,
    required this.topicTotal,
    required this.departmentName,
    required this.officeName,
    required this.roleName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    List<dynamic> postJson = (json['posts'] ?? []) as List;
    List<Post> post = postJson.map((postJson) => Post.fromJson(postJson)).toList();


    return Profile(
        id: (json['id'] ?? 0) as int,
        username: (json['username'] ?? '') as String,
        firstname: (json['firstname'] ?? '') as String,
        lastname: (json['lastname']?? '') as String,
        skills: (json['skills'] ?? '') as String,
        email: (json['email'] ?? '') as String,
        credit: (json['credit'] ?? '0') as String,
        posts: post,
        postTotal: (json['postTotal'] ?? 0) as int,
        topicTotal: (json['topicTotal'] ?? 0) as int,
        departmentName: (json['department_name'] ?? '') as String,
        officeName: (json['office_name'] ?? '') as String,
        roleName: (json['role_name'] ?? '') as String,
        image: (json['image'] ?? '') as String
    );
  }

}
