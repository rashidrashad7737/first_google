import 'package:flutter/material.dart';
import 'package:halls_app/data/database/models/booking_model.dart';
import '/data/database/app_database.dart';


class BookingProvider with ChangeNotifier {
  List<BookingModel> bookings = [];

  Future<void> loadBookings() async {
    final db = await AppDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('bookings');
    bookings = maps.map((map) => BookingModel.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> addBooking(BookingModel booking) async {
    final db = await AppDatabase.instance.database;
    int id = await db.insert('bookings', booking.toMap());
    bookings.add(BookingModel(
      id: id,
      hallId: booking.hallId,
      userId: booking.userId,
      date: booking.date,
      totalPrice: booking.totalPrice,
    ));
    notifyListeners();
  }

  Future<void> updateBooking(BookingModel booking) async {
    final db = await AppDatabase.instance.database;
    await db.update(
      'bookings',
      booking.toMap(),
      where: 'id = ?',
      whereArgs: [booking.id],
    );
    int index = bookings.indexWhere((b) => b.id == booking.id);
    if (index != -1) bookings[index] = booking;
    notifyListeners();
  }

  Future<void> deleteBooking(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(
      'bookings',
      where: 'id = ?',
      whereArgs: [id],
    );
    bookings.removeWhere((b) => b.id == id);
    notifyListeners();
  }
}
