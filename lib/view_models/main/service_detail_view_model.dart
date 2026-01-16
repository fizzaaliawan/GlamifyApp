import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServiceDetailViewModel extends GetxController {
  final String serviceName;
  final int price;
  final String image;
  final double rating;
  final String description;

  ServiceDetailViewModel({
    required this.serviceName,
    required this.price,
    required this.image,
    this.rating = 4.5,
    this.description =
        "This is a high-quality service provided by our expert stylists. Enjoy a personalized experience tailored to your needs.",
  });

  static const Color teal = Colors.teal;

  // Stylist selection
  final stylists = ["Jane Doe", "Emily Smith", "Sophia Lee"];
  var selectedStylistIndex = 0.obs;

  void selectStylist(int index) {
    selectedStylistIndex.value = index;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }
}
