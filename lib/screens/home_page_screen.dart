
import 'package:coffeeui/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/providers/coffee_provider.dart';
import '../presentation/providers/location_provider.dart';
import '../core/utils/product_mapper.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  int crossAxisCount(double screenWidth) {
    return screenWidth < 600 ? 2 : 3;
  }

  String? _selectedLocationId;
  String? _searchQuery;

  @override
  Widget build(BuildContext context) {
    // Fetch coffee types from API
    final coffeeAsync = ref.watch(coffeeListFilteredProvider(
      CoffeeFilters(
        search: _searchQuery,
        availableOnly: true,
      ),
    ));
    
    // Fetch locations
    final locationsAsync = ref.watch(locationListActiveProvider);
    
    // Debug logging
    coffeeAsync.when(
      data: (coffees) => print('Coffee loaded: ${coffees.length} items'),
      loading: () => print('Loading coffee...'),
      error: (error, stack) => print('Coffee error: $error'),
    );
    
    locationsAsync.when(
      data: (locations) => print('Locations loaded: ${locations.length} items'),
      loading: () => print('⏳ Loading locations...'),
      error: (error, stack) => print('Locations error: $error'),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        
        // Convert coffee types to products
        final products = coffeeAsync.when(
          data: (coffees) => coffees.map((c) => c.toProduct()).toList(),
          loading: () => <Product>[],
          error: (_, __) => <Product>[],
        );

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
                          height: MediaQuery.of(context).size.height * 0.35,
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
                                  locationsAsync.when(
                                    data: (locations) => DropdownButton<String>(
                                      value: _selectedLocationId ?? (locations.isNotEmpty ? locations.first.id : null),
                                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                      dropdownColor: Color(0xFF1A1A1A),
                                      items: locations.map((location) {
                                        return DropdownMenuItem(
                                          value: location.id,
                                          child: Text(location.name, style: TextStyle(color: Colors.white)),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedLocationId = value;
                                        });
                                      },
                                    ),
                                    loading: () => DropdownButton<String>(
                                      value: null,
                                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                      dropdownColor: Color(0xFF1A1A1A),
                                      items: [],
                                      onChanged: null,
                                      hint: Text('Loading...', style: TextStyle(color: Colors.grey)),
                                    ),
                                    error: (error, stack) {
                                      print('Locations error in UI: $error');
                                      return DropdownButton<String>(
                                        value: null,
                                        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                        dropdownColor: Color(0xFF1A1A1A),
                                        items: [],
                                        onChanged: null,
                                        hint: Text('Error loading', style: TextStyle(color: Colors.red[300])),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(10)),
                                          child: TextField(
                                            onChanged: (value) {
                                              setState(() {
                                                _searchQuery = value.isEmpty ? null : value;
                                              });
                                            },
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
                    child: coffeeAsync.when(
                      data: (_) => products.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Text(
                                  'No coffee found',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            )
                          : GridView.count(
                              crossAxisCount: crossAxisCount(screenWidth),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: screenWidth < 600 ? 0.65 : 0.75,
                              children: List.generate(products.length, (index) {
                                final product = products[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: GestureDetector(
                            onTap: () {
                              context.push('/detail', extra: product);
                            },
          
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                                    child: Image.asset(
                                      product.imageUrl,
                                      width: double.infinity,
                                      height: screenWidth < 600 ? 100 : 140,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          height: screenWidth < 600 ? 100 : 140,
                                          color: Colors.grey[300],
                                          child: Icon(Icons.coffee, size: 40, color: Colors.grey[600]),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth < 600 ? 14 : 16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      product.description,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: screenWidth < 600 ? 12 : 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                              fontSize: screenWidth < 600 ? 16 : 18,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                      loading: () => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text(
                                'Loading coffee...',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      error: (error, stack) {
                        print('Coffee error in UI: $error');
                        print('Stack: $stack');
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline, size: 48, color: Colors.red),
                                SizedBox(height: 16),
                                Text(
                                  'Error loading coffee',
                                  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  error.toString(),
                                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    // Refresh
                                    ref.invalidate(coffeeListFilteredProvider);
                                  },
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
           
          )
        );
      },
    );
  }
}


