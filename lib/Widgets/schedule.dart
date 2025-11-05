import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//Final version

final supabase = Supabase.instance.client;

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late String selectedDay; // currently selected day
  List<Map<String, dynamic>> routines = [];
  bool isLoading = true;

  final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
  ];

  @override
  void initState() {
    super.initState();
    selectedDay = getTodayDay(); // default = today
    fetchRoutines(selectedDay);
  }

  // ✅ Get today's day name
  String getTodayDay() {
    final today = DateTime.now();
    const days = [
      '', // placeholder since weekday starts from 1
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

  // ✅ Fetch routines from Supabase
  Future<void> fetchRoutines(String day) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await supabase
          .from('routine')
          .select()
          .eq('selectedday', day)
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
    return Container(
      height: 400,
      width: 400,
      child: Column(
        children: [
          // 🔘 Day Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days.map((day) {
                final shortDay = day.substring(0, 3).toUpperCase();
                final isSelected = day == selectedDay;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.red : Colors.blue[900],
                    minimumSize: const Size(20, 40), // width = 50, height = 30
                  ),
                  onPressed: () {
                    setState(() {
                      selectedDay = day;
                    });
                    fetchRoutines(day);
                  },
                  child: Text(
                    shortDay,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          // 🌀 Loading, Empty or List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : routines.isEmpty
                ? Center(
                    child: Text(
                      'No routines found for $selectedDay.',
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                : Card(
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 🕒 Time Card
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Card(
                                  elevation: 8,
                                  child: Center(
                                    child: Text(
                                      time,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),

                              // 📘 Course Card
                              SizedBox(
                                height: 50,
                                width: 120,
                                child: Card(
                                  elevation: 8,
                                  color: isSessional ? Colors.red : Colors.blue,
                                  child: Center(
                                    child: Text(
                                      courseName,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
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
          ),
        ],
      ),
    );
  }
}
