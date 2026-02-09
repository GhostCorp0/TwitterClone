class UserEntity {
  final String email;
  final String username;
  final String password;

  UserEntity({
    required this.email,
    required this.username,
    required this.password
}){
    if(email.trim().isEmpty || !email.contains("@")){
      throw Exception("Invalid email");
    }
    
    if(username.trim().isEmpty){
      throw Exception("Username ca\n not be empty");
    }

    if(password.trim().length < 4){
      throw Exception("Password must be at least 4 characters long");
    }
  }

}