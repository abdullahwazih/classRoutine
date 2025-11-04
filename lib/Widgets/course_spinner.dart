import 'package:class_routine_02/Notifier/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseSpinner extends StatefulWidget {
  const CourseSpinner({super.key});

  @override
  State<CourseSpinner> createState() => _CourseSpinnerState();
}

class _CourseSpinnerState extends State<CourseSpinner> {
  final List<String> courses = ['SWE', 'TWP', 'CN', 'CA', 'AI', 'IMP', 'SWD'];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

    return Center(
      child: SizedBox(
        height: 150,
        child: ListWheelScrollView(
          itemExtent: 50,
          perspective: 0.002,
          diameterRatio: 2.0,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedIndex = index;
              courseProvider.setCourse(courses[index]);
            });
          },
          children: courses.asMap().entries.map((entry) {
            final index = entry.key;
            final course = entry.value;
            final isSelected = index == selectedIndex;
            return Center(
              child: Text(
                course,
                style: TextStyle(
                  fontSize: isSelected ? 20 : 18,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
