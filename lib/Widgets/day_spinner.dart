import 'package:flutter/material.dart';

class DaySpinner extends StatefulWidget {
  const DaySpinner({super.key});

  @override
  State<DaySpinner> createState() => _DaySpinnerState();
}

class _DaySpinnerState extends State<DaySpinner> {
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          // The spinner itself
          SizedBox(
            height: 150,
            child: ListWheelScrollView(
              itemExtent: 50,
              perspective: 0.002, // slight 3D effect
              diameterRatio: 2.0,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: days.asMap().entries.map((entry) {
                final index = entry.key;
                final day = entry.value;
                final isSelected = index == selectedIndex;
                return Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: isSelected ? 20 : 18,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

      // Selected day display
      // Text(
      //   'Selected Day: ${days[selectedIndex]}',
      //   style: const TextStyle(
      //     fontSize: 22,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
