import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';

class BlogModel extends Blog {
  const BlogModel({
    required super.id,
    required super.posterId,
    super.posterName,
    required super.title,
    required super.content,
    required super.topics,
    super.imagePath,
    required super.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      posterId: json['poster_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      topics: List<String>.from(json['topics'] ?? []),
      imagePath: json['image_path'] ?? '',
      updatedAt: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'topics': topics,
      'image_path': imagePath,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? posterName,
    String? title,
    String? content,
    List<String>? topics,
    String? imagePath,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      posterName: posterName ?? this.posterName,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      imagePath: imagePath ?? this.imagePath,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
