import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/features/feed/domain/usecases/create_post_usecase.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/post/create_post_event.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/post/create_post_state.dart';

import '../../../../../core/utils.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostUseCase createPostUseCase;

  CreatePostBloc({required this.createPostUseCase})
    : super(CreatePostInitial()) {
    on<CreatePostRequested>(_createPostsRequested);
  }

  Future<void> _createPostsRequested(
    CreatePostRequested event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(CreatePostLoading());
    try {
      await createPostUseCase.call(
        username: event.username,
        content: event.content,
        userId: event.userId,
        imageUrl: event.imageUrl,
      );
      emit(CreatePostSuccess());
    } catch (e) {
      emit(CreatePostFailure(message: formatError(e)));
    }
  }
}
