//import 'package:coffeeui/models/productList.dart';
import 'package:coffeeui/screens/home_page_screen.dart';
import 'package:coffeeui/screens/onboarding_screen.dart';
import 'package:coffeeui/screens/order_screen.dart';
import 'package:coffeeui/screens/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
  
    MaterialApp(debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => OnboardingScreen(),
      // Add other routes here if needed' 
       '/home': (context) => HomePageScreen(),
       //'/favorites': (context) => DetailItemScreen(product: widget.product), // Placeholder for favorites screen
       '/cart': (context) => OrderScreen(), // Placeholder for cart screen
       'profile': (context) => ProfileScreen(), // Placeholder for profile screen

    },
    ),
  );
}
