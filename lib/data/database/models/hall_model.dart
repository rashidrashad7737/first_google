// lib/data/models/hall_model.dart
class HallModel {
  final int? id;
  final String name;
  final int capacity;
  final double pricePerDay;

  HallModel(
    {
      this.id, required this.name, required this.capacity, required this.pricePerDay});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'capacity': capacity,
      'price_per_day': pricePerDay,
    };
  }

  factory HallModel.fromMap(Map<String, dynamic> map) {
    return HallModel(
      id: map['id'],
      name: map['name'],
      capacity: map['capacity'],
      pricePerDay: map['price_per_day'],
    );
  }
}
