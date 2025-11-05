import 'package:flutter/material.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _ScheduleState();
}

class _ScheduleState extends State<Today> {
  late String todayDay;

  @override
  void initState() {
    super.initState();
    todayDay = getTodayDay();
  }

  // Get today's day name
  String getTodayDay() {
    final today = DateTime.now();
    const days = [
      '', // placeholder for index 0
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[today.weekday];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Text(
          todayDay,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
