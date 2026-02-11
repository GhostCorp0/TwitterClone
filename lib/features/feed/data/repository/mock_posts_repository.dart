import 'package:twitter_clone/features/feed/domain/entities/post_entity.dart';
import 'package:twitter_clone/features/feed/domain/repository/post_repository.dart';

class MockPostsRepository  implements PostRepository{

  @override
  Future<List<PostEntity>> fetchPost() async{
    return [
      PostEntity(userId:'123', username: 'aman', content: 'flutter app', createdAt: DateTime.now()),
      PostEntity(userId:'124 ', username: 'raman', content: 'best content', createdAt: DateTime.now()),
      PostEntity(userId:'125', username: 'naman', content: 'some content', createdAt: DateTime.now()),
      PostEntity(userId:'126', username: 'manan', content: 'another content', createdAt: DateTime.now()),
    ];
  }
}

class MockPostsWithErrorRepository implements PostRepository{
  @override
  Future<List<PostEntity>> fetchPost() {
    throw Exception("Something broke");
  }

}