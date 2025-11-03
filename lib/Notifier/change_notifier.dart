import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  String _selectedCourse = '';

  String get selectedCourse => _selectedCourse;

  void setCourse(String course) {
    _selectedCourse = course;
    notifyListeners();
  }
}

class RoutineProvider extends ChangeNotifier {
  String _selectedDay = 'Monday';
  int _selectedHour = 1;
  int _selectedMinute = 0;
  String _selectedAmPm = 'am';

  String get selectedDay => _selectedDay;
  int get selectedHour => _selectedHour;
  int get selectedMinute => _selectedMinute;
  String get selectedAmPm => _selectedAmPm;

  void setDay(String day) {
    _selectedDay = day;
    notifyListeners();
  }

  void setHour(int hour) {
    _selectedHour = hour;
    notifyListeners();
  }

  void setMinute(int minute) {
    _selectedMinute = minute;
    notifyListeners();
  }

  void setAmPm(String value) {
    _selectedAmPm = value;
    notifyListeners();
  }
}
