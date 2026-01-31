import 'package:flutter/material.dart';
import 'package:halls_app/data/screens/reports_page.dart';
import 'package:halls_app/l10n/app_localizations.dart';
import 'package:halls_app/main.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/hall_provider.dart';
import '../providers/booking_provider.dart';
import 'user_list_screen.dart';
import 'hall_list_screen.dart';
import 'booking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.language,color: Colors.white,),
            onPressed: () {
              if (Localizations.localeOf(context).languageCode == 'ar') {
                MyApp.setLocale(context, const Locale('en'));
              } else {
                MyApp.setLocale(context, const Locale('ar'));
              }
            },
          )
        ],
        centerTitle: true,
        title:  Text(loc.get("Event_Hall_Management") ,style: TextStyle(color: Colors.white),),
        shadowColor: Colors.blue,
        backgroundColor: Localizations.localeOf(context).languageCode=='ar'? Colors.indigo:Colors.teal,
        
      ),
      drawer: Drawer(
        
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                textAlign: TextAlign.center,
                 loc.get('Welcome') ,
                style: TextStyle(color: Colors.white, fontSize: 30 ,),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title:  Text(loc.get('users')),
              onTap: () {
                Provider.of<UserProvider>(context, listen: false).loadUsers();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UserListScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.meeting_room),
              title:  Text (loc.get('halls')),
              onTap: () {
                Provider.of<HallProvider>(context, listen: false).loadHalls();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HallListScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: Text (loc.get('bookings')),
              onTap: () {
                Provider.of<BookingProvider>(context, listen: false).loadBookings();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BookingScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text (loc.get('change language ')),
              onTap: () {
                Locale currentLocale=Localizations.localeOf(context);
                if(currentLocale.languageCode=='en'){
                  MyApp.setLocale(context, const Locale('ar'));
                }else{
                  MyApp.setLocale(context, const Locale('en'));
                }
                // هنا يمكن ربط تغيير اللغة
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          children: [
            _buildCard(context,
                icon: Icons.person,
                title: loc.get("users"),
                color: Colors.blueAccent,
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false).loadUsers();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserListScreen()),
                  );
                }),
            _buildCard(context,
                icon: Icons.meeting_room,
                title: loc.get("halls"),
                color: Colors.orangeAccent,
                onTap: () {
                  Provider.of<HallProvider>(context, listen: false).loadHalls();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HallListScreen()),
                  );
                }),
            _buildCard(context,
                icon: Icons.book_online,
                title: loc.get("bookings"),
                color: Colors.green,
                onTap: () {
                  Provider.of<BookingProvider>(context, listen: false).loadBookings();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BookingScreen()),
                  );
                }),
            _buildCard(context,
                icon: Icons.insights,
                title: loc.get("reports"),
                color: Colors.purpleAccent,
                onTap: () {
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReportsPage()),
                  );
                  //ScaffoldMessenger.of(context).showSnackBar(
                      //const SnackBar(content: Text("Coming Soon!")));

                }),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required IconData icon,
      required String title,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: color.withOpacity(0.85),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
