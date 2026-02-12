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
      throw Exception(e);
    }catch(e){
      throw Exception("Login Failed");
    }
  }

  @override
  Future<String> register({required UserEntity user}) async{
    try{
      final response = await client.auth.signUp(email:user.email,password: user.password,data: {
        'username':user.username
      });
      final session = response.session;
      if(session == null || session.accessToken.isEmpty){
        throw Exception("Invalid Session");
      }
      return session.accessToken;
    }catch(e){
      throw Exception("Register Failed");
    }
  }

}