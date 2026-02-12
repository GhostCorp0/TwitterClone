abstract class FeedEvent {}

class FetchPostsRequested extends FeedEvent {}

class LikePostRequested extends FeedEvent{
  final String postId;
  final String userId;

  LikePostRequested({required this.postId,required this.userId});
}