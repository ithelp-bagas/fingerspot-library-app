import 'package:fingerspot_library_app/models/bookmark_model.dart';
import 'package:fingerspot_library_app/models/comment_model.dart';
import 'package:fingerspot_library_app/models/tag_model.dart';
import 'package:fingerspot_library_app/models/user_model.dart';
import 'package:fingerspot_library_app/models/votes_model.dart';

class Post {
  int id;
  int userId;
  int categoryId;
  int subcategoryId;
  String title;
  String content;
  int postLike;
  int status;
  int postComment;
  User user;
  String createdAt;
  List<Comment> comments;
  List<Votes> votes;
  List<Bookmark> bookmarks;
  List<Tag> tags;
  int views;

  Post({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.subcategoryId,
    required this.title,
    required this.content,
    required this.postLike,
    required this.status,
    required this.postComment,
    required this.user,
    required this.comments,
    required this.votes,
    required this.bookmarks,
    required this.tags,
    required this.createdAt,
    required this.views
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> userJson = json['user'] ?? {};
    List<dynamic> commentJson = (json['comments'] ?? []) as List;
    List<dynamic> votesJson = (json['votes'] ?? []) as List;
    List<dynamic> bookmarkJson = (json['bookmark'] ?? []) as List;
    List<dynamic> tagsJson = (json['tags'] ?? []) as List;

    User user = User.fromJson(userJson);
    List<Comment> comments = commentJson.map((comJson) => Comment.fromJson(comJson)).toList();
    List<Votes> votes = votesJson.map((votJson) => Votes.fromJson(votJson)).toList();
    List<Bookmark> bookmarks = bookmarkJson.map((bookJson) => Bookmark.fromJson(bookJson)).toList();
    List<Tag> tags = tagsJson.map((tagJson) => Tag.fromJson(tagJson)).toList();

    return Post(
      id: (json['id'] ?? 0) as int,
      userId: (json['user_id'] ?? 0) as int,
      categoryId: (json['category_id'] ?? 0) as int,
      subcategoryId: (json['subcategory_id'] ?? 0) as int,
      title: (json['title'] ?? '') as String,
      content: (json['content'] ?? '') as String,
      postLike: (json['post_like'] ?? 0) as int,
      status: (json['status'] ?? 0) as int,
      postComment: (json['post_comment'] ?? 0) as int,
      createdAt: (json['created_at'] ?? '') as String,
      user: user,
      comments: comments,
      votes: votes,
      bookmarks: bookmarks,
      tags: tags,
      views: (json['views'] ?? 0) as int
    );
  }
}
