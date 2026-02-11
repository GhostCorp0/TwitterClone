import 'package:twitter_clone/features/feed/domain/entities/post_entity.dart';
import 'package:twitter_clone/features/feed/domain/repository/post_repository.dart';

class MockPostsRepository implements PostRepository {
  final List<PostEntity> _posts = [
    PostEntity(userId: '123', username: 'aman', content: 'flutter app', createdAt: DateTime.now()),
    PostEntity(userId: '124 ', username: 'raman', content: 'best content', createdAt: DateTime.now()),
    PostEntity(userId: '125', username: 'naman', content: 'some content', createdAt: DateTime.now()),
    PostEntity(userId: '126', username: 'manan', content: 'another content', createdAt: DateTime.now()),
  ];

  @override
  Future<List<PostEntity>> fetchPost() async {
    return List.from(_posts);
  }

  @override
  Future<bool> createPost({required PostEntity post}) async {
    final newPost = PostEntity(
      id: post.id,
      userId: post.userId,
      username: post.username,
      content: post.content,
      createdAt: post.createdAt,
      likesCount: post.likesCount ?? 0,
      commentsCount: post.commentsCount ?? 0,
      repostsCount: post.repostsCount ?? 0,
      imageUrl: post.imageUrl,
    );
    _posts.insert(0, newPost);
    return true;
  }
}

class MockPostsWithErrorRepository implements PostRepository{
  @override
  Future<List<PostEntity>> fetchPost() {
    throw Exception("Something broke");
  }

  @override
  Future<bool> createPost({required PostEntity post}) {
    throw UnimplementedError();
  }

}