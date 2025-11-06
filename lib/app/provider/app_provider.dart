import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {

  int _currentTabIndex = 0;

  int get currentTabIndex => _currentTabIndex;

  void setCurrentTabBy(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }
}
