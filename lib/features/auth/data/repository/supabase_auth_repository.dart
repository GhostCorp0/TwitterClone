import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter_clone/features/auth/domain/entities/user_entity.dart';
import 'package:twitter_clone/features/auth/domain/entities/user_session_entity.dart';
import 'package:twitter_clone/features/auth/domain/models/LoginParams.dart';
import 'package:twitter_clone/features/auth/domain/repository/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient client;

  SupabaseAuthRepository({required this.client});

  @override
  Future<UserSessionEntity> login({required LoginParams loginParams}) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: loginParams.email,
        password: loginParams.password,
      );
      final session = response.session;
      if (session == null || session.accessToken.isEmpty) {
        throw Exception("Invalid Session");
      }

      final user = UserSessionEntity(
        id: session.user.id,
        email: session.user.email!,
        token: session.accessToken,
      );

      return user;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Login failed");
    }
  }

  @override
  Future<UserSessionEntity> register({required UserEntity user}) async {
    try {
      final response = await client.auth.signUp(
        email: user.email,
        password: user.password,
        data: {'username': user.username},
      );

      final session = response.session;

      if(session == null || session.accessToken.isEmpty){
        throw Exception("Invalid session");
      }


      final userSession = UserSessionEntity(
        id: session.user.id,
        email: session.user.email!,
        token: session.accessToken,
      );

      return userSession;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Register failed");
    }
  }
}
