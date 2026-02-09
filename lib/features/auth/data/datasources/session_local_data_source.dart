import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SessionLocalDataSource {
  Future<void> saveToken({required String token});
  Future<String?> getToken();
  Future<void> deleteToken();
}

class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  final FlutterSecureStorage secureStorage;

  SessionLocalDataSourceImpl({required this.secureStorage});

  static const _keyToken = "auth_token";

  @override
  Future<void> deleteToken() async{
    await secureStorage.delete(key:_keyToken);
  }

  @override
  Future<String?> getToken() async{
    return await secureStorage.read(key: _keyToken);
  }

  @override
  Future<void> saveToken({required String token}) async{
    await secureStorage.write(key: _keyToken, value: token);
  }
  
}