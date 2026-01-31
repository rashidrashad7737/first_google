// lib/data/models/user_model.dart
class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;

  UserModel({this.id, required this.name, required this.email, required this.password});

  // تحويل الكائن إلى Map (SQLite يحتاج Map)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // إنشاء كائن من Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
