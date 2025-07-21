//import 'package:coffeeui/models/productList.dart';
import 'package:coffeeui/screens/home_page_screen.dart';
import 'package:coffeeui/screens/onboarding_screen.dart';
import 'package:coffeeui/screens/order_screen.dart';
import 'package:coffeeui/screens/profile_screen.dart';
import 'package:coffeeui/widget%20/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
  
    MaterialApp(debugShowCheckedModeBanner: false,
    home: OnboardingScreen(),
    ),
  );
}
