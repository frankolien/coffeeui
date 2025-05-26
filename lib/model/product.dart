class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  /*List<Product> products = [
    Product(
      id: '1',
      name: 'Espresso',
      description: 'A strong and bold coffee shot.',
      price: 2.50,
      imageUrl: 'lib/images/third_coffee.png', // Update to your image path
    ),
    Product(
      id: '2',
      name: 'Cappuccino',
      description: 'A perfect blend of espresso, steamed milk, and foam.',
      price: 3.00,
      imageUrl: 'assets/images/4.',
    ),
    Product(
      id: '3',
      name: 'Latte',
      description: 'Smooth and creamy with a touch of espresso.',
      price: 3.50,
      imageUrl: 'assets/images/second_coffee.png',
    ),
    Product(
      id: '4',
      name: 'Mocha',
      description: 'A delightful mix of chocolate and coffee.',
      price: 4.00,
      imageUrl: 'assets/images/5.png',
    ),
  ];*/

}