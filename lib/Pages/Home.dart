import 'package:class_routine_02/Notifier/change_notifier.dart';
import 'package:class_routine_02/Widgets/course_spinner.dart';
import 'package:class_routine_02/Widgets/date_today.dart';
import 'package:class_routine_02/Widgets/day_spinner.dart';
import 'package:class_routine_02/Widgets/schedule.dart';
import 'package:class_routine_02/Widgets/timeSpinner.dart';
import 'package:class_routine_02/Widgets/today.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSessional = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> addRoutine(BuildContext context) async {
    final selectedCourse = context.read<CourseProvider>().selectedCourse;
    final selectedHour = context.read<RoutineProvider>().selectedHour;
    final selectedMinute = context.read<RoutineProvider>().selectedMinute;
    final amOrPm = context.read<RoutineProvider>().selectedAmPm;
    final selectedDay = context.read<RoutineProvider>().selectedDay;

    // --- Validation ---
    if (selectedCourse.isEmpty) {
      _showSnack('Please select a course first.');
      return;
    }
    if (selectedDay.isEmpty) {
      _showSnack('Please select a day.');
      return;
    }
    if (selectedHour == null) {
      _showSnack('Please select an hour.');
      return;
    }
    if (selectedMinute == null) {
      _showSnack('Please select minutes.');
      return;
    }
    if (amOrPm.isEmpty) {
      _showSnack('Please select AM/PM.');
      return;
    }

    try {
      await supabase.from('routine').insert({
        'course_name': selectedCourse,
        'hour': selectedHour,
        'minute': selectedMinute,
        'am_pm': amOrPm,
        'is_sessional': isSessional,
        'selectedday': selectedDay,
      });

      _showSnack('Routine added successfully!');
      setState(() {}); // Refresh UI
    } catch (error) {
      _showSnack('Error adding routine: $error');
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final selectedCourse = context.watch<CourseProvider>().selectedCourse;
    final selectedHour = context.watch<RoutineProvider>().selectedHour;
    final selectedMinute = context.watch<RoutineProvider>().selectedMinute;
    final amOrPm = context.watch<RoutineProvider>().selectedAmPm;
    final selectedDay = context.watch<RoutineProvider>().selectedDay;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            // Header showing selected day
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Today(),
                  TodayDateWidget(),
                ],
              ),
            ),

            // Schedule display filtered by selectedDay
            Expanded(child: Schedule()),

            // Day + Time selection
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
                      padding: const EdgeInsets.all(8.0),
                      child: Timespinner(),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),

            // Course selection
            const CourseSpinner(),
            SizedBox(height: 20),
            IconButton(
              onPressed: () {
                setState(() {
                  isSessional = !isSessional;
                });
              },
              icon: const Icon(Icons.adjust),
              color: isSessional ? Colors.redAccent : Colors.white,
              iconSize: 30,
            ),
            const SizedBox(height: 5),
            IconButton(
              onPressed: () => addRoutine(context),
              icon: const Icon(Icons.add),
              iconSize: 30,
              color: Colors.white,
              splashColor: Colors.amberAccent,
            ),
          ],
        ),
      ),
    );
  }
}
