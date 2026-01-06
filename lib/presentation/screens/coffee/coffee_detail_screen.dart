import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/coffee_provider.dart';
import '../../providers/favorite_provider.dart';

class CoffeeDetailScreen extends ConsumerStatefulWidget {
  final String coffeeTypeId;

  const CoffeeDetailScreen({
    super.key,
    required this.coffeeTypeId,
  });

  @override
  ConsumerState<CoffeeDetailScreen> createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends ConsumerState<CoffeeDetailScreen> {
  String? _selectedSize;
  String? _selectedMilkType;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final coffeeAsync = ref.watch(coffeeByIdProvider(widget.coffeeTypeId));
    final isFavoriteAsync = ref.watch(isFavoriteProvider(widget.coffeeTypeId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Details'),
        actions: [
          IconButton(
            icon: isFavoriteAsync.when(
              data: (isFavorite) => Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              loading: () => const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              error: (_, __) => const Icon(Icons.favorite_border),
            ),
            onPressed: () {
              ref.read(favoriteNotifierProvider.notifier).toggleFavorite(widget.coffeeTypeId);
            },
          ),
        ],
      ),
      body: coffeeAsync.when(
        data: (coffee) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (coffee.imageURL != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    coffee.imageURL!,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 300,
                      color: Colors.grey[300],
                      child: const Icon(Icons.coffee, size: 100),
                    ),
                  ),
                )
              else
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Icon(Icons.coffee, size: 100),
                ),
              const SizedBox(height: 24),
              Text(
                coffee.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (coffee.description != null)
                Text(
                  coffee.description!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              const SizedBox(height: 24),
              const Text(
                'Size',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: ['Small', 'Medium', 'Large'].map((size) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(size),
                        selected: _selectedSize == size,
                        onSelected: (selected) {
                          setState(() {
                            _selectedSize = selected ? size : null;
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const Text(
                'Milk Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['Whole', 'Almond', 'Oat', 'Soy'].map((milk) {
                  return ChoiceChip(
                    label: Text(milk),
                    selected: _selectedMilkType == milk,
                    onSelected: (selected) {
                      setState(() {
                        _selectedMilkType = selected ? milk : null;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text(
                    'Quantity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() {
                          _quantity--;
                        });
                      }
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Text(
                    '\$${(coffee.price * _quantity).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement order creation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order functionality coming soon')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B4513),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: const Text('Add to Order'),
                  ),
                ],
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

