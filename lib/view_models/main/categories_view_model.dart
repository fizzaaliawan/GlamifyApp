import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesViewModel extends GetxController {
  final TextEditingController searchController = TextEditingController();

  static const Color teal = Color(0xFF008080);

  // Categories list
  final RxList<Map<String, String>> categories = <Map<String, String>>[
    {'name': 'Hair', 'image': 'assets/images/categories/haircut.jpg'},
    {'name': 'Facials', 'image': 'assets/images/categories/facial.png'},
    {'name': 'Manicures', 'image': 'assets/images/categories/manicure.jpg'},
    {'name': 'Pedicures', 'image': 'assets/images/categories/pedicure.jpg'},
    {'name': 'Massages', 'image': 'assets/images/categories/massage.jpg'},
    {
      'name': 'Bridal Services',
      'image': 'assets/images/categories/bridal_services.png'
    },
  ].obs;
}
