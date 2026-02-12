import 'package:twitter_clone/features/auth/data/datasources/session_local_data_source.dart';

class UserSessionService {
  final SessionLocalDataSource sessionLocalDataSource;

  UserSessionService({required this.sessionLocalDataSource});

  Future<void> persistToken({required String token})async{
    await sessionLocalDataSource.saveToken(token: token);
  }

  Future<void> saveUserId({required String userId})async{
    await sessionLocalDataSource.saveUserId(userId: userId );
  }


  Future<String?> getUserSession({required String token}){
    return sessionLocalDataSource.getToken();
  }

  Future<String?> getUserId(){
    return sessionLocalDataSource.getUserId();
  }

  Future<void> logout(){
    return sessionLocalDataSource.deleteToken();
  }

  Future<bool> isLoggedIn() async{
    final token = await sessionLocalDataSource.getToken();
    return token != null && token.isNotEmpty;
  }

}
