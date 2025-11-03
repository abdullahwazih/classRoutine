import 'package:class_routine_02/Widgets/amPm_spinner.dart';
import 'package:class_routine_02/Widgets/hour_spinner.dart';
import 'package:class_routine_02/Widgets/minute_spinner.dart';
import 'package:flutter/material.dart';

class Timespinner extends StatelessWidget {
  const Timespinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: HourSpinner()),
        Expanded(child: MinuteSpinner()),
        Expanded(child: AmpmSpinner()),
      ],
    );
  }
}
