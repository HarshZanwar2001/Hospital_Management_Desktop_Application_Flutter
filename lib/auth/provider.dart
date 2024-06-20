import 'package:flutter/material.dart';

class UserDataProvider with ChangeNotifier {
  dynamic _userData; 
  dynamic get userData => _userData;
  void setUserData(dynamic newData) {
    _userData = newData;
    notifyListeners(); // Notify listeners about the change
  }
}