
/*import 'package:coffeeui/screens/detail_item_screen.dart';
import 'package:coffeeui/widget%20/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:coffeeui/model/product.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int crossAxisCount(double screenWidth) {
    return screenWidth < 600 ? 2 : 4;
  }

    List<Product> products = [
    Product(
      id: '1',
      name: 'Flat White',
      description: 'Espresso',
      price: 2.50,
      imageUrl: 'lib/images/third_coffee.png', // Update to your image path
    ),
    Product(
      id: '2',
      name: 'Cappuccino',
      description: 'Steamed milk',
      price: 3.00,
      imageUrl: 'lib/images/4.png',
    ),
    Product(
      id: '3',
      name: 'Latte',
      description: 'Ice/hot',
      price: 3.50,
      imageUrl: 'lib/images/second_coffee.png',
    ),
    Product(
      id: '4',
      name: 'Caffe Mocha',
      description: 'Deep foam',
      price: 4.00,
      imageUrl: 'lib/images/5.png',
    ),
    
  ];


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Top Black Section
                Container(
                
                  color: Color(0xFF1A1A1A),
                  padding: EdgeInsets.fromLTRB(24, 48, 24, 24),
                  width: double.infinity,
                  height: screenHeight * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location', style: TextStyle(color: Colors.grey)),
                      DropdownButton<String>(
                        value: 'Location 1',
                        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                        dropdownColor: Color(0xFF1A1A1A),
                        items: [
                          DropdownMenuItem(
                            value: 'Location 1',
                            child: Text('Lagos, Nigeria',
                                style: TextStyle(color: Colors.white)),
                          ),
                          DropdownMenuItem(
                            value: 'Location 2',
                            child: Text('Abuja, Nigeria',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                        onChanged: (_) {},
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search Coffee',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          IconButton(
                            icon:
                                Icon(Icons.filter_alt, color: Colors.brown[300]),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Responsive Banner
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 7,
                          child: Image.asset(
                            'lib/images/Banner1.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Promo',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Get 50% off on your first order',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black54, blurRadius: 4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // Category Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: ['All Coffee', 'Machito', 'Latte', 'Americano']
                        .map((label) => Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                label,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                //SizedBox(height: 2),

                // Coffee Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GridView.count(
                    crossAxisCount: crossAxisCount(screenWidth),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 3 / 4,
                     children: List.generate(products.length, (index) {
  final product = products[index];
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: GestureDetector(
       onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailItemScreen(product: product),
      ),
    );
  },
      
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                product.imageUrl,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(product.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(product.description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    )),
            ),
           Padding(
             padding: const EdgeInsets.only(right: 6.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    // Add to cart action
                  },
                ),
              ),
              ],
             ),
           )
          ],
        ),
      ),
    ),
  );
}),

                  ),
                ),
              ],
            ),
          ),

      bottomNavigationBar:  BottomNavBar(onTap: (int ) {  },),
        );
      },
    );
  }
}*/

// Remember to add the imports

import 'package:coffeeui/model/product.dart';
import 'package:coffeeui/screens/detail_item_screen.dart';
import 'package:coffeeui/screens/order_screen.dart';
import 'package:coffeeui/widget%20/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int crossAxisCount(double screenWidth) {
    return screenWidth < 600 ? 2 : 4;
  }

  List<Product> products = [
    Product(
      id: '1',
      name: 'Flat White',
      description: 'Espresso',
      price: 2.50,
      imageUrl: 'lib/images/third_coffee.png', // Update to your image path
    ),
    Product(id: '2', name: 'Cappuccino', description: 'Steamed milk', price: 3.00, imageUrl: 'lib/images/4.png'),
    Product(id: '3', name: 'Latte', description: 'Ice/hot', price: 3.50, imageUrl: 'lib/images/second_coffee.png'),
    Product(id: '4', name: 'Caffe Mocha', description: 'Deep foam', price: 4.00, imageUrl: 'lib/images/5.png'),

  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Top Black Section
                  Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned(
                        child: Container(
                          color: Color(0xFF1A1A1A),
                          // padding: EdgeInsets.fromLTRB(24, 48, 24, 24),
                          width: double.infinity,
                          height: screenHeight * 0.3,
                        ),
                      ),
          
                      Positioned(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Location', style: TextStyle(color: Colors.grey)),
                                  DropdownButton<String>(
                                    value: 'Location 1',
                                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                    dropdownColor: Color(0xFF1A1A1A),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Location 1',
                                        child: Text('Lagos, Nigeria', style: TextStyle(color: Colors.white)),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Location 2',
                                        child: Text('Abuja, Nigeria', style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                    onChanged: (_) {},
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: screenHeight * 0.05,
                                          decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(10)),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Search Coffee',
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none,
                                              prefixIcon: Icon(Icons.search, color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      IconButton(icon: Icon(Icons.filter_alt, color: Colors.brown[300]), onPressed: () {}),
                                    ],
                                  ),
                                ],
                              ),
                            ),
          
                            // Responsive Banner
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 16 / 7,
                                      child: Image.asset('lib/images/Banner1.png', fit: BoxFit.cover, width: double.infinity),
                                    ),
                                    Positioned(
                                      left: 20,
                                      bottom: 30,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(10)),
                                            child: Text('Promo', style: TextStyle(color: Colors.white, fontSize: 16)),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Get 50% off on your first order',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
          
                            // Category Chips
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children:
                                    ['All Coffee', 'Machito', 'Latte', 'Americano']
                                        .map(
                                          (label) => Container(
                                            margin: EdgeInsets.only(right: 10),
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                            decoration: BoxDecoration(color: Colors.brown, borderRadius: BorderRadius.circular(10)),
                                            child: Text(label, style: TextStyle(color: Colors.white, fontSize: 14)),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          
                  //SizedBox(height: 2),
          
                  // Coffee Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GridView.count(
                      crossAxisCount: crossAxisCount(screenWidth),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 4.5,
                      children: List.generate(products.length, (index) {
                        final product = products[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => DetailItemScreen(product: product)));
                            },
          
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                                    child: Image.asset(product.imageUrl, width: double.infinity, height: 120, fit: BoxFit.cover),
                                  ),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(product.description, style: TextStyle(color: Colors.grey[600])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(
                                            '\$${product.price.toStringAsFixed(2)}',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(color: Colors.brown, borderRadius: BorderRadius.circular(8)),
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: Colors.white),
                                            onPressed: () {
                                              // Add to cart action
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          
            // Bottom Nav
            /*bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
              selectedItemColor: Colors.brown,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),*/
            bottomNavigationBar: BottomNavBar(
              currentIndex: 0,
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
          )
        );
      },
    );
  }
}


