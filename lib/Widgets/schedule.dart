import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late String todayDay; // day of the week
  List<Map<String, dynamic>> routines = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    todayDay = getTodayDay();
    fetchRoutines();
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

  Future<void> fetchRoutines() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await supabase
          .from('routine')
          .select()
          .eq('selectedday', todayDay) // match your column
          .order('hour', ascending: true)
          .order('minute', ascending: true);

      setState(() {
        routines = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error fetching routines: $e')));
    }
  }

  String formatTime(int hour, int minute, String amPm) {
    final minStr = minute.toString().padLeft(2, '0');
    return '$hour:$minStr $amPm';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (routines.isEmpty) {
      return Center(
        child: Text(
          'No routines found for $todayDay.',
          style: const TextStyle(fontSize: 18),
        ),
      );
    }

    return SizedBox(
      height: 400,
      width: 400,
      child: Card(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          itemCount: routines.length,
          itemBuilder: (context, index) {
            final routine = routines[index];
            final time = formatTime(
              routine['hour'] as int,
              routine['minute'] as int,
              routine['am_pm'] as String,
            );
            final courseName = routine['course_name'] as String;
            final isSessional = routine['is_sessional'] as bool;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: Card(
                      elevation: 8,
                      child: Center(
                        child: Text(time, style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                  // Course on the very right
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: Card(
                      elevation: 8,
                      child: Center(
                        child: Text(
                          courseName,
                          style: TextStyle(
                            fontSize: 16,
                            color: isSessional ? Colors.red : Colors.white,
                            fontWeight: isSessional
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
