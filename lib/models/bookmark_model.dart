class Bookmark {
  int id;
  int postId;
  int userId;
  String type;
  String createdAt;
  int? like;
  int? unlike;

  Bookmark({
    required this.id,
    required this.postId,
    required this.userId,
    required this.type,
    required this.createdAt,
    this.like,
    this.unlike,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: (json['id'] ?? 0) as int,
      postId: (json['post_id'] ?? 0) as int,
      userId: (json['user_id'] ?? 0) as int,
      type: (json['type'] ?? '') as String,
      createdAt: (json['created_at'] ?? '') as String,
      like: (json['like'] ?? 0) as int,
      unlike: (json['unlike'] ?? 0) as int,
    );
  }
}