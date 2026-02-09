import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:twitter_clone/features/auth/data/datasources/session_local_data_source.dart';
import 'package:twitter_clone/features/auth/data/repository/MockAuthRepository.dart';
import 'package:twitter_clone/features/auth/domain/usecases/login_usecase.dart';
import 'package:twitter_clone/features/auth/domain/usecases/register_use_case.dart';
import 'package:twitter_clone/features/auth/presentation/home/screens/home_page.dart';
import 'package:twitter_clone/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:twitter_clone/features/auth/presentation/login/screens/login_page.dart';
import 'features/auth/domain/services/user_session_service.dart';
import 'features/auth/presentation/register/bloc/register_bloc.dart';
import 'features/auth/presentation/register/screens/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final SessionLocalDataSource sessionLocalDataSource = SessionLocalDataSourceImpl(secureStorage:secureStorage);
    final UserSessionService userSessionService = UserSessionService(sessionLocalDataSource:sessionLocalDataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(
            registerUseCase: RegisterUseCase(
              authRepository: MockAuthRepository(),
            ),
            userSessionService: userSessionService
          ),
          child: RegisterPage(),
        ),
        BlocProvider(
          create: (_) => LoginBloc(
            loginUseCase: LoginUseCase(authRepository: MockAuthRepository()),
            userSessionService: userSessionService
          ),
          child: LoginPage(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Demo",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: "/login",
        routes: {
          "/register": (_) => const RegisterPage(),
          "/login": (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
        },
      ),
    );
  }
}
