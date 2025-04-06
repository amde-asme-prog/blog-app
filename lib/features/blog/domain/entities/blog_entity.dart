class Blog {
  const Blog({
    required this.id,
    required this.posterId,
    this.posterName,
    required this.title,
    required this.content,
    required this.topics,
    this.imagePath,
    required this.updatedAt,
  });

  final String id;
  final String posterId;
  final String? posterName;
  final String title;
  final String content;
  final List<String> topics;
  final String? imagePath;
  final DateTime updatedAt;
}
