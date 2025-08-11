import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  AppView currentView = AppView.login;

  Future<void> restoreView() async {
    final prefs = await SharedPreferences.getInstance();
    final last = prefs.getString('lastView');
    currentView = last != null ? AppViewExtension.fromString(last) : AppView.login;
  }

  Future<void> setView(AppView view) async {
    currentView = view;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastView', view.name);
    notifyListeners();
  }
}

enum AppView {
  login,
  forgotPassword,
  dashboardHome,
  tcs,
}

extension AppViewExtension on AppView {
  String get name => toString().split('.').last;

  static AppView fromString(String value) {
    return AppView.values.firstWhere((e) => e.name == value, orElse: () => AppView.login);
  }
}
