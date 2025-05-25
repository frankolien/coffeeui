/*import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int crossAxisCount(double screenWidth) {
    return screenWidth < 600 ? 2 : 4;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    return LayoutBuilder(
       builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        double horizontalPadding = screenWidth < 600 ? 16.0 : 32.0;
        double cardHeight = screenHeight * (screenWidth < 600 ? 0.175 : 0.22);
        double searchBarWidth = screenWidth < 600 ? screenWidth - 100 : 400;

      return Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              //child: Stack(
              child: Column(
                children: [
                  // Black section
                  Container(
                    color: Color(0xFF1A1A1A),
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Search & Profile Row
                            Text(
                              'Location',
                              style: TextStyle(color: Colors.grey),
                            ),
                            DropdownButton(
                              value: 'Location 1',
      
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              dropdownColor: Color(0xFF1A1A1A),
                              items: [
                                DropdownMenuItem(
                                  value: 'Location 1',
                                  child: Text(
                                    'Lagos,Nigeria',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Location 2',
                                  child: Text(
                                    'Abuja ,Nigeria',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                            SizedBox(height: 20), // Space between elements
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Search bar
                                Container(
                                  width: screenWidth * 0.75,
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
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                // Profile icon
                                IconButton(
                                  icon: Icon(
                                    Icons.filter_alt,
                                    color: Colors.brown,
                                  ),
                                  onPressed: () {
                                    // Profile action
                                  },
                                ),
                              ],
                            ),
      
                            SizedBox(height: 25), // Space between elements
                            Row(children: []),
                            SizedBox(height: 25), // Space for the card bridge
                          ],
                        ),
                      ),
                    ),
                  ),
      
                  // White section
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.1, // Space for banner
                        ),
                        // Space for overlapping card
                        // Categories and Grid content
                        Container(
                          padding: EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            //horizontal scroll view
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // Category cards
                                Container(
                                  width: 100,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        // Handle tap
                                      },
                                      splashColor: Colors.blue.withOpacity(
                                        0.3,
                                      ), // Color when tapped
                                      highlightColor: Colors.grey.withOpacity(
                                        0.2,
                                      ), // Color when held down
                                      hoverColor: Colors.grey.withOpacity(
                                        0.1,
                                      ), // Color when hovered (web/desktop)
                                      borderRadius: BorderRadius.circular(8),
                                      child: Text(
                                        'All Coffee',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Machito',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                // Add more categories as needed
                                Container(
                                  width: 100,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Latte',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Americano',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.count(crossAxisCount: crossAxisCount(screenWidth),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(10, (index) {
                              return Card(
                                margin: EdgeInsets.all(8),
                                child: Center(
                                  child: Text('Coffee Item ${index + 1}'),
                                ),
                              );
                            }),
                          ),
                        ),    
                      ]
                    ),
                  ),
                
                ],
              ),
      
              // Overlapping card
      
              //],
              //),
            ),
            Positioned(
              left: screenWidth * 0.05,
              //right: screenWidth * 0.07,
              top: screenHeight * 0.25, // adjust as needed
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Background image
                    Image.asset(
                      'lib/images/Banner1.png',
                      //width: screenWidth * 0.86,
                      height: screenHeight * 0.175,
                      fit: BoxFit.cover,
                    ),
      
                    // Text overlay
                    Positioned(
                      left: 20,
                      bottom: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Promo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.6),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
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
                                  color: Colors.black.withOpacity(0.7),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.brown,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            // Handle navigation
          },
        ),
      );
      }
    );
  }

}*/



import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int crossAxisCount(double screenWidth) {
    return screenWidth < 600 ? 2 : 4;
  }

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
                SizedBox(height: 2),

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
                    children: List.generate(8, (index) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text('Coffee Item ${index + 1}'),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Nav
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: Colors.brown,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}


