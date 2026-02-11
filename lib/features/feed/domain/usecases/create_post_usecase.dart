import 'package:twitter_clone/features/feed/domain/entities/post_entity.dart';
import 'package:twitter_clone/features/feed/domain/repository/post_repository.dart';

class CreatePostUseCase {
  final PostRepository postRepository;

  CreatePostUseCase({required this.postRepository});

  Future<void> call({
    required String userId,
    required String username,
    required String content,
    String? imageUrl,
  }) {
    final post = PostEntity(
        userId: userId,
        username: username,
        content: content,
        createdAt:DateTime.now(),
        likesCount:0,
        commentsCount: 0,
        repostsCount: 0,
        imageUrl: imageUrl);
    final result = postRepository.createPost(post:post);
    return result;
  }
}
