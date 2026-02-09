import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, emit) async {
    emit(LoginLoading());
    try {
      await loginUseCase.call(
        email: event.email,
       password: event.password,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(message:formatError(e)));
    }
  }
}
