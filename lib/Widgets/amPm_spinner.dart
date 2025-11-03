import 'package:class_routine_02/Notifier/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmpmSpinner extends StatefulWidget {
  const AmpmSpinner({super.key});

  @override
  State<AmpmSpinner> createState() => _amOrPmpinnerState();
}

class _amOrPmpinnerState extends State<AmpmSpinner> {
  final List<String> amOrPm = ['am', 'pm'];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(
      context,
      listen: false,
    );
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
                  routineProvider.setAmPm(amOrPm[index]);

                });
              },
              children: amOrPm.asMap().entries.map((entry) {
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
      //   'Selected Day: ${amOrPm[selectedIndex]}',
      //   style: const TextStyle(
      //     fontSize: 22,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
