class User {
  final int id;
  final String email;
  final String password;
  final String type;
  User(
      {required this.id,
      required this.email,
      required this.password,
      required this.type
      }
  );
     

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'type': type,
    };
  }

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          email: json['email'],
          password: json['password'],
          type: json['type'],
        );
}