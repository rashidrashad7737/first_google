import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:halls_app/data/providers/booking_provider.dart';
import 'package:halls_app/data/providers/hall_provider.dart';

import 'package:halls_app/data/providers/user_provider.dart';
import 'package:halls_app/data/screens/login_screen.dart';
import 'package:halls_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => HallProvider()),
      ChangeNotifierProvider(create: (_) => BookingProvider()),
      
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state =
        context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ar');

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halls App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      locale: _locale,
      
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        // Delegates for built-in localization of widgets
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const LoginScreen(),
    );
  }
}
