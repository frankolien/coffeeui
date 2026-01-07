import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:coffeeui/screens/onboarding_screen.dart';
import 'package:coffeeui/screens/home_page_screen.dart';
import 'package:coffeeui/screens/detail_item_screen.dart';
import 'package:coffeeui/screens/order_screen.dart';
import 'package:coffeeui/screens/profile_screen.dart';
import 'package:coffeeui/model/product.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/location/location_selection_screen.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../core/di/dependency_injection.dart';
import 'package:coffeeui/widget /bottom_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _getInitialLocation(SharedPreferences? prefs) {
  if (prefs != null) {
    final token = prefs.getString('auth_token');
    if (token != null && token.isNotEmpty) {
      return '/home';
    }
  }
  return '/onboarding';
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  final initialLocation = _getInitialLocation(prefs);
  
  final router = GoRouter(
    initialLocation: initialLocation,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isAuthenticated = authState.isAuthenticated;
      final isLoading = authState.isLoading;
      
      if (isLoading) {
        return null;
      }
      
      final isOnboarding = location == '/onboarding';
      final isLogin = location == '/login';
      final isRegister = location == '/register';
      final isAuthRoute = isOnboarding || isLogin || isRegister;
      
      if (isAuthRoute) {
        if (isAuthenticated) {
          return '/home';
        }
        return null;
      }
      
      if (!isAuthenticated && !isAuthRoute) {
        return '/onboarding';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: '/location-selection',
        name: 'location-selection',
        builder: (context, state) {
          return const LocationSelectionScreen();
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          int currentIndex = 0;
          final location = state.matchedLocation;
          if (location == '/home') {
            currentIndex = 0;
          } else if (location == '/favorites') {
            currentIndex = 1;
          } else if (location == '/orders') {
            currentIndex = 2;
          } else if (location == '/notifications') {
            currentIndex = 3;
          }
          
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavBar(currentIndex: currentIndex),
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomePageScreen(),
          ),
          GoRoute(
            path: '/favorites',
            name: 'favorites',
            builder: (context, state) => Scaffold(
              appBar: AppBar(
                title: Text('Favorites'),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              body: Center(
                child: Text('Favorites Screen'),
              ),
            ),
          ),
          GoRoute(
            path: '/orders',
            name: 'orders',
            builder: (context, state) => const OrderScreen(),
          ),
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            builder: (context, state) => Scaffold(
              appBar: AppBar(
                title: Text('Notifications'),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              body: Center(
                child: Text('Notifications Screen'),
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/detail',
        name: 'detail',
        builder: (context, state) {
          final product = state.extra as Product?;
          if (product == null) {
            return const Scaffold(
              body: Center(child: Text('Product not found')),
            );
          }
          return DetailItemScreen(product: product);
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
  
  return router;
});

