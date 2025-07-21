import 'package:coffeeui/model/product.dart';
import 'package:coffeeui/screens/detail_item_screen.dart';
import 'package:coffeeui/screens/home_page_screen.dart';
import 'package:coffeeui/screens/order_screen.dart';
import 'package:coffeeui/widget%20/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 24, color: Colors.brown),
      ),
      ),
    );
  }
}