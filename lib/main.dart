import 'package:class_routine_02/Notifier/change_notifier.dart';
import 'package:class_routine_02/Pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://iplwgaxalsvuvkakuhqb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlwbHdnYXhhbHN2dXZrYWt1aHFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIyMTUxOTcsImV4cCI6MjA3Nzc5MTE5N30.VMqXehJ83RmxihiDSyo81ZRwkLQ3FBqNmVGd1jo8JN0',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => RoutineProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark, // Force dark mode
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
