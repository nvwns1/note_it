class User{
  late String id;
  late String email;
  late String userName;

  User({
    required this.id,
    required this.email,
    required this.userName
});

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      id: json['id'],
      email: json['email'],
      userName: json['userName'],
    );
  }
}