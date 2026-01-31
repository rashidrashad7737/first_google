import 'package:flutter/material.dart';
import 'package:halls_app/data/database/models/booking_model.dart';
import 'package:halls_app/data/database/models/hall_model.dart';
import 'package:halls_app/data/database/models/user_model.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../providers/hall_provider.dart';
import '../providers/user_provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  UserModel? selectedUser;
  HallModel? selectedHall;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUsers();
      Provider.of<HallProvider>(context, listen: false).loadHalls();
      Provider.of<BookingProvider>(context, listen: false).loadBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final hallProvider = Provider.of<HallProvider>(context);
    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("اضافه حجز")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DropdownButtonFormField<UserModel>(
              value: selectedUser,
              hint: const Text(" اختر مستخدم"),
              items: userProvider.users.map((user) {
                return DropdownMenuItem<UserModel>(
                  value: user,
                  child: Text(user.name),
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedUser = val),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<HallModel>(
              value: selectedHall,
              hint: const Text(" اختر قاعه "),
              items: hallProvider.halls.map((hall) {
                return DropdownMenuItem<HallModel>(
                  value: hall,
                  child: Text(hall.name),
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedHall = val),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: "التاريخ"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (selectedUser != null &&
                    selectedHall != null &&
                    _dateController.text.isNotEmpty) {
                  final booking = BookingModel(
                    userId: selectedUser!.id!,
                    hallId: selectedHall!.id!,
                    date: _dateController.text,
                    totalPrice: selectedHall!.pricePerDay,
                  );
                  bookingProvider.addBooking(booking);

                  setState(() {
                    selectedUser = null;
                    selectedHall = null;
                    _dateController.clear();
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields")),
                  );
                }
              },
              child: const Text(" اضافه حجز"),
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
            ),
            const Divider(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: bookingProvider.bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookingProvider.bookings[index];
                  final hall = hallProvider.halls.firstWhere((h) => h.id == booking.hallId);
                  final user = userProvider.users.firstWhere((u) => u.id == booking.userId);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text("${user.name} → ${hall.name}"),
                      subtitle: Text("Date: ${booking.date} | Cost: \$${booking.totalPrice}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
