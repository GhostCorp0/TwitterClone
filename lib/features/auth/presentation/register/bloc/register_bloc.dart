import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/features/auth/domain/usecases/register_use_case.dart';
import 'package:twitter_clone/features/auth/presentation/register/bloc/register_event.dart';
import 'package:twitter_clone/features/auth/presentation/register/bloc/register_state.dart';

import '../../../../../core/utils.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase}) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(RegisterSubmitted event, emit) async {
    emit(RegisterLoading());
    try {
      await registerUseCase.call(
        email: event.email,
        username: event.username,
        password: event.password,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(message:formatError(e)));
    }
  }
}
