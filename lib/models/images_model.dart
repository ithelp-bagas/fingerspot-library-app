class Images {
  int id;
  int postId;
  int userId;
  String image;
  String path;

  Images({
    required this.id,
    required this.postId,
    required this.userId,
    required this.image,
    required this.path,
  });


  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: (json['id'] ?? 0) as int,
      postId: (json['postId'] ?? 0) as int,
      userId: (json['userId'] ?? 0) as int,
      image: (json['image'] ?? '') as String,
      path: (json['path'] ?? '') as String,
    );
  }

}