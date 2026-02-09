import 'package:twitter_clone/features/auth/domain/entities/user_entity.dart';
import 'package:twitter_clone/features/auth/domain/models/LoginParams.dart';
import 'package:twitter_clone/features/auth/domain/repository/auth_repository.dart';

class MockAuthRepository  implements AuthRepository{
  @override
  Future<String> register({required UserEntity user}) async{
    return 'token';
  }

  @override
  Future<String> login({required LoginParams loginParams}) async{
    return 'token';
  }
}

class MockAuthErrorRepository  implements AuthRepository {
  @override
  Future<String> register({required UserEntity user}) async{
    throw Exception("Registration failed");
  }

  @override
  Future<String> login({required LoginParams loginParams}) async{
    throw Exception("Login failed");
  }
}