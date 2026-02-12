import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter_clone/features/auth/domain/entities/user_entity.dart';
import 'package:twitter_clone/features/auth/domain/models/LoginParams.dart';
import 'package:twitter_clone/features/auth/domain/repository/auth_repository.dart';
class SupabaseAuthRepository implements AuthRepository{
  final SupabaseClient client;

  SupabaseAuthRepository({required this.client});

  @override
  Future<String> login({required LoginParams loginParams}) async{
    try{
      final response = await client.auth.signInWithPassword(email:loginParams.email,password: loginParams.password);
      final session = response.session;
      if(session == null || session.accessToken.isEmpty){
        throw Exception("Invalid Session");
      }
      return session.accessToken;
    } on AuthException catch(e){
      throw Exception(e.message);
    }catch(e){
      throw Exception("Login failed");
    }
  }

  @override
  Future<String> register({required UserEntity user}) async{
    try{
      final response = await client.auth.signUp(email:user.email,password: user.password,data: {
        'username':user.username
      });
      if (response.user == null) {
        throw Exception("Registration failed");
      }
      // If email confirmation is enabled in Supabase, session can be null here.
      return response.session?.accessToken ?? '';
    } on AuthException catch (e) {
      throw Exception(e.message);
    }catch(e){
      throw Exception("Register failed");
    }
  }

}