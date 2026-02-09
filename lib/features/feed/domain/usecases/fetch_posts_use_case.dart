import 'package:twitter_clone/features/feed/domain/entities/post_entity.dart';
import 'package:twitter_clone/features/feed/domain/repository/post_repository.dart';

class FetchPostsUseCase {
  final PostRepository postRepository;

  FetchPostsUseCase({required this.postRepository});

  Future<List<PostEntity>> call() async {
    final result = postRepository.fetchPost();
    return result;
  }

}