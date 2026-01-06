import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/coffee_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/coffee_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? _selectedLocationId;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _crossAxisCount(double screenWidth) {
    return screenWidth < 600 ? 2 : 3;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final locationsAsync = ref.watch(locationListActiveProvider);
    final coffeeFilters = CoffeeFilters(
      search: _searchController.text.isEmpty ? null : _searchController.text,
      availableOnly: true,
    );
    final coffeeAsync = ref.watch(coffeeListFilteredProvider(coffeeFilters));

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;

          return Column(
            children: [
              Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Container(
                    color: const Color(0xFF1A1A1A),
                    width: double.infinity,
                    height: screenHeight * 0.35,
                  ),
                  Positioned(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Location', style: TextStyle(color: Colors.grey)),
                                      locationsAsync.when(
                                        data: (locations) => DropdownButton<String>(
                                          value: _selectedLocationId ?? locations.firstOrNull?.id,
                                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                                          dropdownColor: const Color(0xFF1A1A1A),
                                          items: locations.map((location) {
                                            return DropdownMenuItem(
                                              value: location.id,
                                              child: Text(
                                                location.name,
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedLocationId = value;
                                            });
                                          },
                                        ),
                                        loading: () => const Text('Loading...', style: TextStyle(color: Colors.white)),
                                        error: (_, __) => const Text('Error', style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.person, color: Colors.white),
                                    onPressed: () => context.push('/profile'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
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
                                        controller: _searchController,
                                        decoration: InputDecoration(
                                          hintText: 'Search Coffee',
                                          hintStyle: const TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                                        ),
                                        onChanged: (_) => setState(() {}),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  IconButton(
                                    icon: Icon(Icons.filter_alt, color: Colors.brown[300]),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                                const Positioned(
                                  left: 20,
                                  bottom: 30,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: ['All Coffee', 'Espresso', 'Latte', 'Cappuccino']
                                .map(
                                  (label) => Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.brown,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      label,
                                      style: const TextStyle(color: Colors.white, fontSize: 14),
                                    ),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: coffeeAsync.when(
                    data: (coffees) => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _crossAxisCount(screenWidth),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3 / 4.5,
                      ),
                      itemCount: coffees.length,
                      itemBuilder: (context, index) {
                        final coffee = coffees[index];
                        return CoffeeCard(
                          coffee: coffee,
                          onTap: () => context.push('/coffee/${coffee.id}'),
                        );
                      },
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(
                      child: Text('Error: $error'),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/orders');
              break;
            case 2:
              context.go('/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

