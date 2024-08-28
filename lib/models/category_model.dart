class Category {
  int id;
  String name;
  int status;
  int postsCount;

  Category({
    required this.id,
    required this.name,
    required this.status,
    required this.postsCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: (json['id'] ?? 0) as int,
        name: (json['name'] ?? '') as String,
        status: (json['status']?? 0) as int,
        postsCount: (json['posts_count'] ?? 0) as int
    );
  }

}