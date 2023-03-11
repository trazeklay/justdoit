class User {
  String id;
  String name;
  String password;
  String email;
  String? profilePicPath;
  int? colorId;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    this.profilePicPath,
    this.colorId,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    data['profilePicturePath'] = profilePicPath;
    data['colorId'] = colorId;
    return data;
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
      profilePicPath: json['profilePicturePath'],
      colorId: json['colorId'],
    );
  }
}
