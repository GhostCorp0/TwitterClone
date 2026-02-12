import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter_clone/features/auth/domain/entities/user_entity.dart';
import 'package:twitter_clone/features/auth/domain/entities/user_session_entity.dart';
import 'package:twitter_clone/features/auth/domain/models/LoginParams.dart';

abstract class AuthRepository {
  Future<UserSessionEntity> register({required UserEntity user});
  Future<UserSessionEntity> login({required LoginParams loginParams});
}