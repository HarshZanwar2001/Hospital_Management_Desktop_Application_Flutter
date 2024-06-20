import 'package:flutter/material.dart';

class patienthistoryData with ChangeNotifier {
  dynamic _patienthistoryData; 
  dynamic get userData => _patienthistoryData;
  void setUserData(dynamic newData) {
    _patienthistoryData = newData;
    notifyListeners(); // Notify listeners about the change
  }
}