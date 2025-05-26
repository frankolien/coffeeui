import 'package:coffeeui/screens/home_page_screen.dart';
import 'package:coffeeui/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
  
    MaterialApp(debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => OnboardingScreen(),
      // Add other routes here if needed' 
       '/home': (context) => HomePageScreen(),

    },
    ),
  );
}
