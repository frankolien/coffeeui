import 'package:coffeeui/screens/home_page_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background color
      body: Container(
        // Dark background color
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              bottom: 200,
              child: Image.asset('lib/images/6.png'),
            ),
            // Content layout
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Push content to bottom
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Spacer to push content down
                    Spacer(flex: 3),

                    // Main heading text
                    Text(
                      'Fall in Love with\nCoffee in Blissful\nDelight!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      ),
                    ),

                    SizedBox(height: 16),

                    // Subtitle text
                    Text(
                      'Welcome to our cozy coffee corner, where every cup is a delightful for you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 40),

                    // Get Started button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your navigation logic here
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePageScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(
                            0xFFD28B67,
                          ), // Coffee/orange color from screenshot
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    // Bottom spacing
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
