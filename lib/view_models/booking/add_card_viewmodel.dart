import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardViewModel extends GetxController {
  final cardNumber = ''.obs;
  final cardName = ''.obs;
  final expiry = ''.obs;

  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final nameController = TextEditingController();

  Null get cvv => null;

  void addCard() {}

  @override
  void onClose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
