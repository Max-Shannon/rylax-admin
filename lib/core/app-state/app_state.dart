import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  AppView currentView = AppView.login;
  int selectedDevelopmentID = 0;

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

  Future<void> setSelectedDevelopmentId(int id) async {
    selectedDevelopmentID = id; // set immediately
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastSelectedDevelopmentId', id);
    notifyListeners();
  }
}

enum AppView { login, forgotPassword, dashboardHome, developmentsView, developmentView, tcs }

extension AppViewExtension on AppView {
  String get name => toString().split('.').last;

  static AppView fromString(String value) {
    return AppView.values.firstWhere((e) => e.name == value, orElse: () => AppView.login);
  }
}
