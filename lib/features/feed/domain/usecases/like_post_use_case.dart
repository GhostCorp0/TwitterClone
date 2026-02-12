import 'package:twitter_clone/features/feed/domain/repository/post_repository.dart';

class LikePostUseCase {
  final PostRepository postRepository;

  LikePostUseCase({required this.postRepository});

  Future<bool> call({required String userId,required String postId})async{
    final result = await postRepository.likePost(
      userId:userId,
      postId:postId,
    );
    return result;
  }

}