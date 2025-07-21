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

}

final List<Product> products = [
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