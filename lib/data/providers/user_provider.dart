import 'package:flutter/material.dart';
import 'package:halls_app/data/database/app_database.dart';
import 'package:halls_app/data/database/models/user_model.dart';


class UserProvider with ChangeNotifier {
  List<UserModel> users = [];

  // تحميل جميع المستخدمين من قاعدة البيانات
  Future<void> loadUsers() async {
    final db = await AppDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    users = maps.map((map) => UserModel.fromMap(map)).toList();
    notifyListeners();
  }

  // إضافة مستخدم جديد
  Future<void> addUser(UserModel user) async {
    final db = await AppDatabase.instance.database;
    int id = await db.insert('users', user.toMap());
    users.add(UserModel(
      id: id,
      name: user.name,
      email: user.email,
      password: user.password,
    ));
    notifyListeners();
  }

  // تحديث مستخدم
  Future<void> updateUser(UserModel user) async {
    final db = await AppDatabase.instance.database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
    int index = users.indexWhere((u) => u.id == user.id);
    if (index != -1) users[index] = user;
    notifyListeners();
  }

  // حذف مستخدم
  Future<void> deleteUser(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    users.removeWhere((u) => u.id == id);
    notifyListeners();
  }
}
