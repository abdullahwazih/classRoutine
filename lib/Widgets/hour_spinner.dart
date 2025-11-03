import 'package:class_routine_02/Notifier/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HourSpinner extends StatefulWidget {
  const HourSpinner({super.key});

  @override
  State<HourSpinner> createState() => _HourSpinnerState();
}

class _HourSpinnerState extends State<HourSpinner> {
  final List<int> hours = List.generate(12, (index) => index + 1); 

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(
      context,
      listen: false,
    );

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
              routineProvider.setHour(hours[index]);
            });
          },
          children: hours.asMap().entries.map((entry) {
            final index = entry.key;
            final hour = entry.value;
            final isSelected = index == selectedIndex;
            return Center(
              child: Text(
                hour.toString(),
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
