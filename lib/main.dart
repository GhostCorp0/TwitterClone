import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:twitter_clone/features/auth/data/datasources/session_local_data_source.dart';
import 'package:twitter_clone/features/auth/data/repository/MockAuthRepository.dart';
import 'package:twitter_clone/features/auth/domain/usecases/login_usecase.dart';
import 'package:twitter_clone/features/auth/domain/usecases/register_use_case.dart';
import 'package:twitter_clone/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:twitter_clone/features/auth/presentation/login/screens/login_page.dart';
import 'package:twitter_clone/features/feed/data/repository/mock_posts_repository.dart';
import 'package:twitter_clone/features/feed/domain/usecases/create_post_usecase.dart';
import 'package:twitter_clone/features/feed/domain/usecases/fetch_posts_use_case.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:twitter_clone/features/feed/presentation/screens/feed_page.dart';
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
    final SessionLocalDataSource sessionLocalDataSource =
        SessionLocalDataSourceImpl(secureStorage: secureStorage);
    final UserSessionService userSessionService = UserSessionService(
      sessionLocalDataSource: sessionLocalDataSource,
    );

    final postRepository = MockPostsRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(
            registerUseCase: RegisterUseCase(
              authRepository: MockAuthRepository(),
            ),
            userSessionService: userSessionService,
          )
        ),
        BlocProvider(
          create: (_) => LoginBloc(
            loginUseCase: LoginUseCase(authRepository: MockAuthRepository()),
            userSessionService: userSessionService,
          )
        ),
        BlocProvider(
          create: (_) => FeedBloc(
            fetchPostsUseCase: FetchPostsUseCase(postRepository: postRepository),
          )
        ),
        BlocProvider(
          create: (_) => CreatePostBloc(
            createPostUseCase: CreatePostUseCase(postRepository: postRepository),
          )
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
          '/home': (_) => const FeedPage(),
        },
      ),
    );
  }
}
