abstract class CreatePostEvent {}

class CreatePostRequested extends CreatePostEvent {
  final String username;
  final String content;
  final String userId;
  final String? imageUrl;

  CreatePostRequested({
    required this.username,
    required this.content,
    required this.userId,
    this.imageUrl,
  });
}
