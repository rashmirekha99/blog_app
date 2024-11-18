class Blog {
  final String id;
  final DateTime updatedAt;
  final String posterId;
  final String title;
  final String content;
  final List<String> topics;
  final String imageUrl;
  final String? posterName;

  Blog({
    required this.id,
    required this.updatedAt,
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
    required this.imageUrl,
    this.posterName
  });
}
