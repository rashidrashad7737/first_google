import 'package:flutter/material.dart';
import 'package:halls_app/data/database/models/hall_model.dart';
import 'package:halls_app/l10n/app_localizations.dart';
import 'package:halls_app/main.dart';
import 'package:provider/provider.dart';
import '../providers/hall_provider.dart';

class HallListScreen extends StatefulWidget {
  const HallListScreen({super.key});

  @override
  State<HallListScreen> createState() => _HallListScreenState();
}

class _HallListScreenState extends State<HallListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HallProvider>(context, listen: false).loadHalls();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hallProvider = Provider.of<HallProvider>(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.get("القاعات ")),
      actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              if (Localizations.localeOf(context).languageCode == 'ar') {
                MyApp.setLocale(context, const Locale('en'));
              } else {
                MyApp.setLocale(context, const Locale('ar'));
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: hallProvider.halls.length,
                itemBuilder: (context, index) {
                  final hall = hallProvider.halls[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(hall.name[0].toUpperCase())),
                      title: Text(hall.name),
                      subtitle: Text("Capacity: ${hall.capacity}, Price: \$${hall.pricePerDay}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // يمكن إضافة deleteHall لاحقًا
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "اسم القاعه"),
                ),
                TextField(
                  controller: _capacityController,
                  decoration: const InputDecoration(labelText: "السعه"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: "السعر اليومي"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _capacityController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty) {
                      final hall = HallModel(
                        name: _nameController.text,
                        capacity: int.parse(_capacityController.text),
                        pricePerDay: double.parse(_priceController.text),
                      );
                      hallProvider.addHall(hall);

                      _nameController.clear();
                      _capacityController.clear();
                      _priceController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(" من فضلك املا الحقول")),
                      );
                    }
                  },
                  child: const Text("اضافه قاعه"),
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
