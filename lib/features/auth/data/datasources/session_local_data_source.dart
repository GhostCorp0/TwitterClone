import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:twitter_clone/features/auth/domain/entities/user_session_entity.dart';

abstract class SessionLocalDataSource {
  Future<void> saveSession({required UserSessionEntity session});

  Future<UserSessionEntity?> getSession();

  Future<void> clearSession();
}

class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  final FlutterSecureStorage secureStorage;

  SessionLocalDataSourceImpl({required this.secureStorage});

  static const _keyToken = "auth_token";
  static const _keyUserId = "user_id";
  static const _keyEmail = "user_email";

  @override
  Future<void> clearSession() async {
    await Future.wait([
      secureStorage.delete(key: _keyToken),
      secureStorage.delete(key: _keyUserId),
      secureStorage.delete(key: _keyEmail),
    ]);
  }

  @override
  Future<void> saveSession({required UserSessionEntity session}) async {
    await secureStorage.write(key: _keyToken, value: session.token);
    await secureStorage.write(key: _keyUserId, value: session.id);
    await secureStorage.write(key: _keyEmail, value: session.email);
  }

  @override
  Future<UserSessionEntity?> getSession() async {
    final token = await secureStorage.read(key: _keyToken);
    final id = await secureStorage.read(key: _keyUserId);
    final email = await secureStorage.read(key: _keyEmail);
    if (token == null || id == null || email == null) {
      return null;
    }

    return UserSessionEntity(id: id, email: email, token: token);
  }
}
