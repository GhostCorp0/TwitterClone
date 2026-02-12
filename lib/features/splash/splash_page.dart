import 'package:flutter/material.dart';
import 'package:twitter_clone/features/auth/domain/services/user_session_service.dart';

class SplashPage extends StatefulWidget {
  final UserSessionService userSessionService;

  const SplashPage({super.key, required this.userSessionService});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    _checkSession();
    super.initState();
  }

  Future<void> _checkSession() async{
    final isLoggedIn = await widget.userSessionService.isLoggedIn();
    if(!mounted) return;
    if(isLoggedIn){
      Navigator.pushReplacementNamed(context,"/home");
    }else{
      Navigator.pushReplacementNamed(context,"/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 48,
          height: 48,
        ),
      ),
    );
  }
}
