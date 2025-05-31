import 'package:coffeeui/screens/detail_item_screen.dart';
import 'package:coffeeui/screens/home_page_screen.dart';
import 'package:coffeeui/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:coffeeui/model/product.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    this.currentIndex = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      //onTap: onTap,
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
      },
      selectedItemColor: Colors.brown,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: const [
        
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
