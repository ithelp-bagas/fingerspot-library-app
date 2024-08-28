class Pivot {
  String taggableType;
  int taggableId;
  int tagId;
  DateTime createdAt;
  DateTime updatedAt;
  int orderId;

  Pivot({
    required this.taggableType,
    required this.taggableId,
    required this.tagId,
    required this.createdAt,
    required this.updatedAt,
    required this.orderId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      taggableType: (json['taggable_type'] ?? '') as String,
      taggableId: (json['taggable_id'] ?? 0) as int,
      tagId: (json['tag_id'] ?? 0) as int,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      orderId: (json['order_id'] ?? 0) as int,
    );
  }
}