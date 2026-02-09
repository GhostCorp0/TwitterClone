import 'package:twitter_clone/features/feed/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> fetchPost();
}