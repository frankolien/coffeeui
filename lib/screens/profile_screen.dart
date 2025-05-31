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
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Set the current index to 3 for Profile
        onTap: (index) {
        // Handle navigation based on the tapped index
        if (index == 0) {
          //Navigator.pushReplacementNamed(context, '/home');
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen()));
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailItemScreen(product: products[index]), // Navigate to OrderScreen
            ),
          );
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen()));
        } else if (index == 3) {
          Navigator.pushReplacementNamed(context, 'profile');
        }
      }
      ),

      body: Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 24, color: Colors.brown),
      ),
      ),
    );
  }
}