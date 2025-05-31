import 'package:coffeeui/model/product.dart';
import 'package:coffeeui/screens/detail_item_screen.dart';
import 'package:coffeeui/screens/home_page_screen.dart';
import 'package:coffeeui/widget%20/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String selectedSize = 'Deliver'; // Default selected size
  final List<String> sizes = ['Deliver', 'Pickup']; // List of sizes
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = MediaQuery.of(context).size.width < 360;
    final isLargeScreen = MediaQuery.of(context).size.width > 600;
    final isExtraLargeScreen = MediaQuery.of(context).size.width > 800;
    final isTablet =
        MediaQuery.of(context).size.width > 600 &&
        MediaQuery.of(context).size.width < 900;
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isVerySmallScreen = MediaQuery.of(context).size.width < 300;
    final isVeryLargeScreen = MediaQuery.of(context).size.width > 1200;
    final isExtraSmallScreen = MediaQuery.of(context).size.width < 360;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          // Handle navigation based on the tapped index
          if (index == 0) {
            //Navigator.pushReplacementNamed(context, '/home');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => DetailItemScreen(
                      product: products[index],
                    ), // Navigate to OrderScreen
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, 'profile');
          }
        },
      ),
      appBar: AppBar(title: Text('Order'), backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.all(16),

            //padding: EdgeInsets.all(16),
            //height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  sizes.map((size) {
                    final isSelected = size == selectedSize;

                    return SizedBox(
                      width: screenWidth * 0.45, // Adjust width as needed
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.brown : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? Colors.brown.shade700
                                      : Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            size,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Delivery Address',
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Gbagada,Lagos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          //SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '123 Coffee Street, Brewtown',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  //height: 45,
                  width: screenWidth * 0.4,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.edit_document, color: Colors.grey[600]),
                      SizedBox(width: 8),
                      screenWidth > 600
                          ? Text(
                            'Edit Address',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : Text(
                            'Edit Address',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ],
                  ),
                ),
              ),
              Container(
                //height: 45,
                width: screenWidth * 0.4,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.note_add, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    screenWidth > 600
                        ? Text(
                          'Add Note',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        : Text(
                          'Add Note',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 40,
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.grey[300],
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index].imageUrl),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products[index].name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      products[index].description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.remove_circle_outline, color: Colors.brown),
                    SizedBox(width: 8),
                    Text(
                      '1',
                      style: TextStyle(fontSize: 16, color: Colors.brown),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.add_circle_outline, color: Colors.brown),
                  ],
                ),
                //trailing: Text('\$${products[index].price.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, color: Colors.brown)),
              );
            },
            itemCount: 1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 60,
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.verified, color: Colors.black),
                    Text(
                      '1 Discount is Applied',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: null,
                    ),
                    //Text('\$${products[0].price.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Payment Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Text(
                  '\$${products[0].price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, color: Colors.brown),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Fee',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Text(
                  '\$2.00',
                  style: TextStyle(fontSize: 16, color: Colors.brown),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '\$${(products[0].price + 2.00).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wallet, color: Colors.brown),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cash/Wallet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '\$${(products[0].price + 2.00).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Colors.brown),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle order confirmation
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Confirm Order',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
