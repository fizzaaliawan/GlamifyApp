import 'package:flutter/material.dart';
import 'admin_services_screen.dart';
import 'admin_categories_screen.dart';
import 'admin_users_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> adminOptions = [
      {
        'title': 'Manage Services',
        'icon': Icons.miscellaneous_services,
        'color': Colors.teal,
        'screen': const AdminServicesScreen(),
      },
      {
        'title': 'Manage Categories',
        'icon': Icons.category,
        'color': Colors.orange,
        'screen': const AdminCategoriesScreen(),
      },
      {
        'title': 'Manage Users',
        'icon': Icons.people,
        'color': Colors.blue,
        'screen': const AdminUsersScreen(),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Benne',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: adminOptions.map((option) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => option['screen']),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: option['color'],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(option['icon'], size: 50, color: Colors.white),
                    const SizedBox(width: 24),
                    Text(
                      option['title'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Benne',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
