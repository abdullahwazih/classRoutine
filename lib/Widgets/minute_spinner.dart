import 'package:class_routine_02/Notifier/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinuteSpinner extends StatefulWidget {
  const MinuteSpinner({super.key});

  @override
  State<MinuteSpinner> createState() => _MinuteSpinnerState();
}

class _MinuteSpinnerState extends State<MinuteSpinner> {
  final List<int> minutes = List.generate(60, (index) => index); 

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
              routineProvider.setMinute(minutes[index]);
            });
          },
          children: minutes.asMap().entries.map((entry) {
            final index = entry.key;
            final minute = entry.value;
            final isSelected = index == selectedIndex;
            return Center(
              child: Text(
                minute.toString().padLeft(2, '0'), // display 00, 01, 02...
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
