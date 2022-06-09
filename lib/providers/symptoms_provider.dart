import 'package:flutter/material.dart';

class SymptomsProvider extends ChangeNotifier {
  late List<String> _symptoms;
  SymptomsProvider(List<String> data) {
    _symptoms = data;
  }

  List<String> get getSymptoms => _symptoms;

  set setSymptoms(List<String> data) {
    _symptoms = data;
    // notifyListeners();
  }
}
