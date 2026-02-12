import 'package:twitter_clone/features/feed/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> fetchPost();
  Future<bool> createPost({required PostEntity post});
  Future<bool> likePost({required String userId,required String postId});
}