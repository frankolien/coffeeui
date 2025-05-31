import 'package:coffeeui/screens/home_page_screen.dart';
import 'package:coffeeui/screens/order_screen.dart';
import 'package:coffeeui/widget%20/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:coffeeui/model/product.dart';

class DetailItemScreen extends StatefulWidget {
  final Product product;
  // Declare the product variable here  

  const DetailItemScreen({super.key, required this.product});

  @override
  State<DetailItemScreen> createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  String selectedSize = 'M'; // Declare the variable here

  final List<String> sizes = ['S', 'M', 'L'];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      /*bottomNavigationBar: BottomNavBar(
        currentIndex: 0, // Set the current index to 0 for Home
        onTap: (index) {
          // Handle navigation based on the tapped index
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            //Navigator.pushReplacementNamed(context, '/favorites');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DetailItemScreen(product: widget.product), // Navigate to DetailItemScreen
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/cart');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, 'profile');
          }
        },
      ),*/
         /*bottomNavigationBar: BottomNavigationBar(
              currentIndex: 1,

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
        currentIndex: 1, // Set the current index to 1 for Favorites
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
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          )
        ],
      ),
      body: 
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(borderRadius: BorderRadiusGeometry.circular(10), child: Image.asset(widget.product.imageUrl, width: double.infinity, height: 250, fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.product.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ),
                Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.delivery_dining, color: Colors.brown)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.coffee, color: Colors.brown)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.local_cafe, color: Colors.brown)),
                  ],
                )
              ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8.0),
             child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Text( '4.5', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Colors.grey[700])),
                SizedBox(width: 3),
                Text("(230)")
              ],
             ),
           ),
           Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "A classic favorite with equal parts espresso, steamed milk, and airy foam.",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Size', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ),
            Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: sizes.map((size) {
          final isSelected = size == selectedSize;
        
          return SizedBox(
            width: screenWidth * 0.25, // Adjust width as needed
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = size;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.brown : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.brown.shade700 : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: Text(
                  size,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
            ),
            //Spacer(),
            SizedBox(height: screenHeight * 0.07), // Add some space before the button
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Row(
                   children: [
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          //SizedBox(height: 8),
                          Text(
                            '\$${widget.product.price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 18, color: Colors.brown),
                          ),
                        ],
                      ),
                   ],
                 ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: screenWidth * 0.5, // Adjust width as needed
                      height: screenHeight * 0.06, // Adjust height as needed
                      child: ElevatedButton(
                        onPressed: () {
                          // Add to cart action
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(), // Navigate to OrderScreen
                            ),
                          );
                        },
                       child: Text('Buy Now'),
                        style: ElevatedButton.styleFrom(
                          
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          
                          backgroundColor:  Colors.brown, // Coffee color
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
