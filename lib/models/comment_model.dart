class Comment {
  int id;
  int postId;
  int userId;
  String type;
  String comment;
  int? parentCommentId;
  int status;
  int view;
  String createdAt;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.type,
    required this.comment,
    required this.parentCommentId,
    required this.status,
    required this.view,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: (json['id'] ?? 0) as int,
        postId: (json['post_id'] ?? 0) as int,
        userId: (json['user_id'] ?? 0) as int,
        type: (json['type'] ?? '') as String,
        comment: (json['comment'] ?? '') as String,
        parentCommentId: (json['parent_comment_id'] ?? 0) as int,
        status: (json['status'] ?? 0) as int,
        view: (json['id'] ?? 0) as int,
        createdAt: (json['created_at'] ?? '') as String,
    );
  }

}