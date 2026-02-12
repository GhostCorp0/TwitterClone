import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/features/auth/domain/services/user_session_service.dart';
import 'package:twitter_clone/features/feed/domain/usecases/like_post_use_case.dart';

import '../../../../../core/utils.dart';
import '../../../domain/usecases/fetch_posts_use_case.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent,FeedState>{
  FetchPostsUseCase fetchPostsUseCase;
  LikePostUseCase likePostUseCase;
  UserSessionService userSessionService;

  FeedBloc({required this.fetchPostsUseCase,required this.likePostUseCase,required this.userSessionService}) : super(FeedInitial()){
    on<FetchPostsRequested>(_fetchPostsRequested);
    on<LikePostRequested>(_onLikePostRequested);
  }

  Future<void> _fetchPostsRequested(FetchPostsRequested event,Emitter<FeedState> emit) async {
    emit(FeedLoading());
    try{
      final session = await userSessionService.getUserSession();
      final posts = await fetchPostsUseCase.call(currentUserId:session?.id);
      emit(FeedLoaded(posts: posts));
    }catch(e){
      emit(FeedFailure(message:formatError(e)));
    }
  }

  Future<void> _onLikePostRequested(LikePostRequested event,Emitter<FeedState> emit) async{
    try{
      await likePostUseCase.call(userId:event.userId,postId:event.postId);
      add(FetchPostsRequested());
    }catch(e){
      emit(FeedFailure(message: formatError(e)));
    }
  }
}