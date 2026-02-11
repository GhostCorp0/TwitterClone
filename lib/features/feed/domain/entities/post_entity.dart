class PostEntity {
  final String? id;
  final String userId;
  final String username;
  final String content;
  final DateTime createdAt;
  final int? likesCount;
  final int? commentsCount;
  final int? repostsCount;
  final String? imageUrl;

  PostEntity({
    this.id,
    required this.userId,
    required this.username,
    required this.content,
    required this.createdAt,
    this.likesCount,
    this.commentsCount,
    this.repostsCount,
    this.imageUrl,
  });
}
