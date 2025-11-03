import 'package:class_routine_02/Notifier/change_notifier.dart';
import 'package:class_routine_02/Widgets/course_spinner.dart';
import 'package:class_routine_02/Widgets/day_spinner.dart';
import 'package:class_routine_02/Widgets/routine.dart';
import 'package:class_routine_02/Widgets/timeSpinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCourse = context.watch<CourseProvider>().selectedCourse;
    final selectedHour = context.watch<RoutineProvider>().selectedHour;
    final selectedMinute = context.watch<RoutineProvider>().selectedMinute;
    final amOrPm = context.watch<RoutineProvider>().selectedAmPm;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Monday', style: TextStyle(fontSize: 24)),
                  Text(
                    '2 November 2025',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Routine(),
            SizedBox(
              width: 400,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DaySpinner(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Timespinner(),
                    ),
                  ),
                  SizedBox(width: 33),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const CourseSpinner(),
            Expanded(
              child: Text(
                'Selected Course: ${amOrPm.isEmpty ? "None" : amOrPm}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
