import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/features/feed/domain/usecases/fetch_posts_use_case.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/feed_event.dart';

import '../../../../core/utils.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent,FeedState>{
  FetchPostsUseCase fetchPostsUseCase;

  FeedBloc({required this.fetchPostsUseCase}) : super(FeedInitial()){
    on<FetchPostsRequested>(_fetchPostsRequested);
  }

  Future<void> _fetchPostsRequested(FetchPostsRequested event,Emitter<FeedState> emit) async {
    try{
      emit(FeedLoading());
      final posts = await fetchPostsUseCase.call();
      emit(FeedLoaded(posts: posts));
    }catch(e){
      emit(FeedFailure(message:formatError(e)));
    }
  }
}