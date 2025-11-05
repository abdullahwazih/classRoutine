import 'package:flutter/material.dart';

class TodayDateWidget extends StatelessWidget {
  const TodayDateWidget({super.key});

  String getTodayDate() {
    final now = DateTime.now();
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final day = now.day;
    final month = months[now.month];
    final year = now.year;

    return '$day $month $year';
  }

  @override
  Widget build(BuildContext context) {
    final todayDate = getTodayDate();

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Text(
          todayDate,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
