import 'package:flutter/material.dart';
import 'package:coffeeui/model/product.dart';

class DetailItemScreen extends StatefulWidget {
  final Product product;

  const DetailItemScreen({super.key, required this.product});

  @override
  State<DetailItemScreen> createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  String selectedSize = 'Medium'; // Declare the variable here

  final List<String> sizes = ['S', 'M', 'L'];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "A classic favorite with equal parts espresso, steamed milk, and airy foam. Rich and robust, with a light, frothy finish.",
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: screenWidth * 0.5, // Adjust width as needed
                      height: screenHeight * 0.06, // Adjust height as needed
                      child: ElevatedButton(
                        onPressed: () {
                          // Add to cart action
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
            ),
          )
        ],
      ),
    );
  }
}
