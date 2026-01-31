
class BookingModel {
  final int? id;
  final int hallId;
  final int userId;
  final String date;
  final double totalPrice;

  BookingModel({
    this.id,
    required this.hallId,
    required this.userId,
    required this.date,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hall_id': hallId,
      'user_id': userId,
      'date': date,
      'total_price': totalPrice,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      hallId: map['hall_id'],
      userId: map['user_id'],
      date: map['date'],
      totalPrice: map['total_price'],
    );
  }
}
