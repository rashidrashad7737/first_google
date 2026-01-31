import 'package:flutter/material.dart';
import 'package:halls_app/data/database/app_database.dart';
import 'package:halls_app/data/database/models/user_model.dart';


class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      _currentUser = UserModel.fromMap(result.first);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(UserModel user) async {
    final db = await AppDatabase.instance.database;
    int id = await db.insert('users', user.toMap());
    return id > 0;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
