import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.white,
      ),
      body: authState.user != null
          ? SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info Card
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.brown,
                        child: Text(
                          authState.user!.fullName[0].toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        authState.user!.fullName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(authState.user!.email),
                      trailing: authState.user!.isAdmin
                          ? Chip(
                              label: Text('Admin'),
                              backgroundColor: Colors.orange[100],
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 24),
                  // Menu Items
                  ListTile(
                    leading: Icon(Icons.shopping_cart, color: Colors.brown),
                    title: Text('My Orders'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => context.push('/orders'),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.brown),
                    title: Text('Favorites'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to favorites
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.brown),
                    title: Text('Settings'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to settings
                    },
                  ),
                  Divider(),
                  SizedBox(height: 24),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await ref.read(authStateProvider.notifier).logout();
                        if (context.mounted) {
                          context.go('/onboarding');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}