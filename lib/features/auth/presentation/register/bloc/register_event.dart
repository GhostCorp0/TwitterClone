abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent{
  final String email;
  final String username;
  final String password;

  RegisterSubmitted({required this.email, required this.username, required this.password});

}