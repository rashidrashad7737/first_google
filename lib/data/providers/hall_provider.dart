import 'package:flutter/material.dart';
import 'package:halls_app/data/database/app_database.dart';
import 'package:halls_app/data/database/models/hall_model.dart';


class HallProvider with ChangeNotifier {
  List<HallModel> halls = [];

  Future<void> loadHalls() async {
    final db = await AppDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('halls');
    halls = maps.map((map) => HallModel.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> addHall(HallModel hall) async {
    final db = await AppDatabase.instance.database;
    int id = await db.insert('halls', hall.toMap());
    halls.add(HallModel(
      id: id,
      name: hall.name,
      capacity: hall.capacity,
      pricePerDay: hall.pricePerDay,
    ));
    notifyListeners();
  }

  Future<void> updateHall(HallModel hall) async {
    final db = await AppDatabase.instance.database;
    await db.update(
      'halls',
      hall.toMap(),
      where: 'id = ?',
      whereArgs: [hall.id],
    );
    int index = halls.indexWhere((h) => h.id == hall.id);
    if (index != -1) halls[index] = hall;
    notifyListeners();
  }

  Future<void> deleteHall(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(
      'halls',
      where: 'id = ?',
      whereArgs: [id],
    );
    halls.removeWhere((h) => h.id == id);
    notifyListeners();
  }
}
