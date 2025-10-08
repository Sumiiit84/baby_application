import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/baby_setup_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/diaper_screen.dart';
import 'screens/feeding_screen.dart';
import 'screens/sleep_screen.dart';
import 'screens/timeline_screen.dart';

class BabyMoodTracker extends StatelessWidget {
  final String startRoute;
  const BabyMoodTracker({super.key, required this.startRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby & Mood Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink[100],
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.pink[800],
          ),
          bodyMedium: TextStyle(fontSize: 18, color: Colors.grey[800]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: startRoute,
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/setup': (context) => const BabySetupScreen(),
        '/home': (context) => const HomeScreen(),
        '/feeding': (context) => const FeedingScreen(),
        '/diaper': (context) => const DiaperScreen(),
        '/sleep': (context) => const SleepScreen(),
        '/timeline': (context) => const TimelineScreen(),
      },
    );
  }
}
