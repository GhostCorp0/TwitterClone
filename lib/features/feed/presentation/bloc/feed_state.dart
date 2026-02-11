import 'package:equatable/equatable.dart';
import 'package:twitter_clone/features/feed/domain/entities/post_entity.dart';

abstract class FeedState  extends Equatable{
  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState{}

class FeedLoading extends FeedState{}

class FeedLoaded extends FeedState{
  final List<PostEntity> posts;

  FeedLoaded({required this.posts});
}

class FeedFailure extends FeedState{
  final String message;
  FeedFailure({required this.message});
}

