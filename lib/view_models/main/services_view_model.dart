import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesViewModel extends GetxController {
  final String categoryName;

  ServicesViewModel({required this.categoryName});

  static const Color teal = Color(0xFF008080);

  // All services
  final List<Map<String, dynamic>> _allServices = const [
    {
      "name": "Elegant Haircut",
      "price": 30,
      "category": "Hair",
      "image": "eleganthaircut.jpg",
    },
    {
      "name": "Hair Coloring",
      "price": 100,
      "category": "Hair",
      "image": "haircoloring.png",
    },
    {
      "name": "Deluxe Manicure",
      "price": 25,
      "category": "Manicures",
      "image": "deluxemanicure.jpg",
    },
    {
      "name": "Facial Mask",
      "price": 80,
      "category": "Facials",
      "image": "facialmask.jpg",
    },
    {
      "name": "Relaxing Massage",
      "price": 70,
      "category": "Massages",
      "image": "relaxingmassage.jpg",
    },
    {
      "name": "Bridal Makeup",
      "price": 200,
      "category": "Bridal Services",
      "image": "bridal_services.png",
    },
  ];

  // Filtered services based on category
  RxList<Map<String, dynamic>> filteredServices = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterServices();
  }

  void filterServices() {
    final selected = categoryName.toLowerCase();
    filteredServices.value = _allServices
        .where((s) => s["category"].toString().toLowerCase() == selected)
        .toList();
  }
}
