import '../../domain/entities/coffee_type_entity.dart';
import '../../model/product.dart';

extension ProductMapper on CoffeeTypeEntity {
  Product toProduct() {
    return Product(
      id: id,
      name: name,
      description: description ?? '',
      price: price,
      imageUrl: imageURL ?? 'lib/images/third_coffee.png',
    );
  }
}

extension CoffeeTypeMapper on Product {
  CoffeeTypeEntity toCoffeeTypeEntity() {
    return CoffeeTypeEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      imageURL: imageUrl,
      isAvailable: true,
    );
  }
}

