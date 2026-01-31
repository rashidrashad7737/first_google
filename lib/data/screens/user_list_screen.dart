import 'package:flutter/material.dart';
import 'package:halls_app/data/database/models/user_model.dart';
import 'package:halls_app/l10n/app_localizations.dart';
import 'package:halls_app/main.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';


class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 169, 164, 177),
        title: Text(loc.get('users')),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final user = userProvider.users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(user.name[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        userProvider.deleteUser(user.id!);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: loc.get('name')),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: loc.get('email')),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: loc.get('password')),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      final user = UserModel(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      userProvider.addUser(user);

                      _nameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(loc.get('add_user')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
