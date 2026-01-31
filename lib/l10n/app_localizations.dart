import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations(Localizations.localeOf(context));
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'name': 'Name',
      'users': 'Users',
      'halls': 'Halls',
      'bookings': 'Bookings',
      'home': 'Home',
      'add_user': 'Add User',
      'welcome': 'Welcome',
      'change_language': 'Change Language',
      'hall_name': 'Hall name',
      'reports' : 'ٌReports',
      'Event_Hall_Management':'Event Hall Management',
      'Welcome':'Welcome'
    },
    'ar': {
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'name': 'الاسم',
      'users': 'المستخدمون',
      'halls': 'القاعات',
      'bookings': 'الحجوزات',
      'home': 'الرئيسية',
      'add_user': 'إضافة مستخدم',
      'welcome': 'أهلا بك',
      'change_language': 'تغيير اللغة',
      'hall_name': ' اسم القاعه',
      'reports' : 'التقارير',
      'Event_Hall_Management':'اداره قاعه المناسبات',
      'Welcome':'مرحبا'

    }
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>{

    const AppLocalizationsDelegate();
    
    @override
  bool isSupported (Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations>load(Locale locale)async{
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations>old){
    return false;
  }


}
  

