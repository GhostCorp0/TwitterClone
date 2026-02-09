import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils.dart';
import '../../../domain/services/user_session_service.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;
  UserSessionService userSessionService;

  LoginBloc({required this.loginUseCase,required this.userSessionService}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, emit) async {
    emit(LoginLoading());
    try {
      final token = await loginUseCase.call(
        email: event.email,
        password: event.password,
      );
      await userSessionService.persistToken(token: token);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(message: formatError(e)));
    }
  }
}
