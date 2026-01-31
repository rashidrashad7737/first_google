import 'package:flutter/material.dart';
import 'package:halls_app/data/database/models/user_model.dart';
import 'package:halls_app/l10n/app_localizations.dart';
import 'package:halls_app/main.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLogin = true; // true = login, false = register

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final loc =AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.get('login')),
        actions: [
          IconButton(
            onPressed: (){
              if(Localizations.localeOf(context).languageCode=='ar'){
                MyApp.setLocale(context, const Locale('en'));
              }
              else{
                MyApp.setLocale(context, const Locale('ar'));
              }
            }, 
            icon: const Icon(Icons.language))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        isLogin ? loc.get("login") : loc.get("register"),
                        
                      
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration:  InputDecoration(
                        labelText: loc.get("email"),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration:  InputDecoration(
                        labelText: loc.get("password"),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        if (isLogin) {
                          // تسجيل الدخول
                          final user = userProvider.users.firstWhere(
                              (u) =>
                                  u.email == _emailController.text &&
                                  u.password == _passwordController.text,
                              orElse: () => UserModel(
                                  name: '', email: '', password: ''));
                          if (user.id != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomeScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("بيانات اعتماد غير صالحه")),
                            );
                          }
                        } else {
                          // تسجيل مستخدم جديد
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            final user = UserModel(
                                name: _emailController.text.split('@')[0],
                                email: _emailController.text,
                                password: _passwordController.text);
                            userProvider.addUser(user);
                            setState(() {
                              isLogin = true;
                            });
                            _emailController.clear();
                            _passwordController.clear();
                          }
                        }
                      },
                      child: Text(
                        isLogin ? loc.get("login") : loc.get("register")
                        
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(isLogin
                            ? "ليس لديك حساب  ؟ سجل الان "
                            : "هل لديك حساب بالفعل ؟ تسجيل الدخول")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
