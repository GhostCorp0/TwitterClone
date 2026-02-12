import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SessionLocalDataSource {
  Future<void> saveToken({required String token});
  Future<void> saveUserId({required String userId});
  Future<String?> getToken();
  Future<String?> getUserId();
  Future<void> deleteToken();
}

class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  final FlutterSecureStorage secureStorage;

  SessionLocalDataSourceImpl({required this.secureStorage}) ;

  static const _keyToken = "auth_token";
  static const _userId = "user_id";

  @override
  Future<void> deleteToken() async{
    await secureStorage.delete(key:_keyToken);
  }

  @override
  Future<String?> getToken() async{
    return await secureStorage.read(key: _keyToken);
  }

  @override
  Future<String?> getUserId () async{
    return await secureStorage.read(key: _userId );
  }

  @override
  Future<void> saveUserId({required String userId }) async{
    await secureStorage.write(key: _userId, value:userId);
  }

  @override
  Future<void> saveToken({required String token}) async{
    await secureStorage.write(key: _keyToken, value: token);
  }
  
}