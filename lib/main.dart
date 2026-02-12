import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter_clone/features/auth/data/datasources/session_local_data_source.dart';
import 'package:twitter_clone/features/auth/data/repository/supabase_auth_repository.dart';
import 'package:twitter_clone/features/auth/domain/usecases/login_usecase.dart';
import 'package:twitter_clone/features/auth/domain/usecases/register_use_case.dart';
import 'package:twitter_clone/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:twitter_clone/features/auth/presentation/login/screens/login_page.dart';
import 'package:twitter_clone/features/feed/data/repository/supabase_posts_repository.dart';
import 'package:twitter_clone/features/feed/domain/usecases/create_post_usecase.dart';
import 'package:twitter_clone/features/feed/domain/usecases/fetch_posts_use_case.dart';
import 'package:twitter_clone/features/feed/domain/usecases/like_post_use_case.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:twitter_clone/features/feed/presentation/screens/feed_page.dart';
import 'package:twitter_clone/features/splash/splash_page.dart';
import 'features/auth/domain/services/user_session_service.dart';
import 'features/auth/presentation/register/bloc/register_bloc.dart';
import 'features/auth/presentation/register/screens/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://gyqmkvbytgjcosgxfqph.supabase.co',
    anonKey: 'sb_secret_NwS3qS_F9EauKLD1dzJymw_Uqs9LPuh',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final SessionLocalDataSource sessionLocalDataSource =
        SessionLocalDataSourceImpl(secureStorage: secureStorage);
    final UserSessionService userSessionService = UserSessionService(
      sessionLocalDataSource: sessionLocalDataSource,
    );
    return Provider<UserSessionService>.value(
      value: userSessionService,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => RegisterBloc(
              registerUseCase: RegisterUseCase(
                authRepository: SupabaseAuthRepository(client: supabase),
              ),
              userSessionService: userSessionService,
            ),
          ),
          BlocProvider(
            create: (_) => LoginBloc(
              loginUseCase: LoginUseCase(
                authRepository: SupabaseAuthRepository(client: supabase),
              ),
              userSessionService: userSessionService,
            ),
          ),
          BlocProvider(
            create: (_) => FeedBloc(
              fetchPostsUseCase: FetchPostsUseCase(
                postRepository: SupabasePostsRepository(client: supabase),
              ),
              likePostUseCase: LikePostUseCase(
                postRepository: SupabasePostsRepository(client: supabase),
              ),
              userSessionService: userSessionService
            ),
          ),
          BlocProvider(
            create: (_) => CreatePostBloc(
              createPostUseCase: CreatePostUseCase(
                postRepository: SupabasePostsRepository(client: supabase),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter Demo",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          initialRoute: "/splash",
          routes: {
            "/splash": (_) =>
                SplashPage(userSessionService: userSessionService),
            "/register": (_) => const RegisterPage(),
            "/login": (_) => const LoginPage(),
            '/home': (_) => const FeedPage(),
          },
        ),
      ),
    );
  }
}
