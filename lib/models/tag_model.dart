class Tag {
  int id;
  String name;
  String createdAt;

  Tag({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '') as String,
      createdAt: (json['created_at'] ?? '') as String,
    );
  }

}