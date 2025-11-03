import 'package:flutter/material.dart';

class Routine extends StatefulWidget {
  const Routine({super.key});

  @override
  State<Routine> createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 350,
      child: Card(
        color: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Column(
            
          ),
        ),
      ),
      );
  }
}