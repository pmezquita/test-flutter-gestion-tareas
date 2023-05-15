import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier{
  DateTime _selectedDate = DateTime.now();
  bool _enabled = true;


  bool get enabled => _enabled;

  void toggleEnabled() {
    _enabled = !_enabled;
    notifyListeners();
  }

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime date){
    _selectedDate = date;
    notifyListeners();
  }
}