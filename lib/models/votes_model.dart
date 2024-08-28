class Votes {
  int id;
  int postId;
  int userId;
  String type;
  String createdAt;
  int? like;
  int? unlike;

  Votes({
    required this.id,
    required this.postId,
    required this.userId,
    required this.type,
    required this.createdAt,
    this.like,
    this.unlike,
  });

  factory Votes.fromJson(Map<String, dynamic> json) {
    return Votes(
      id: (json['id'] ?? 0) as int,
      postId: (json['post_id'] ?? 0) as int,
      userId: (json['user_id'] ?? 0) as int,
      type: (json['type'] ?? '') as String,
      createdAt: (json['created_at'] ?? '') as String,
      like: json['like'] as int?,
      unlike: json['unlike'] as int?,
    );
  }

}