// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LogoutViewModel extends GetxController {
  var isLoading = false.obs;

  // Teal color
  static const Color teal = Color(0xFF008080);

  Future<void> logout() async {
    try {
      isLoading.value = true;

      // Simulate logout delay or API call
      await Future.delayed(const Duration(seconds: 2));

      // Success Snackbar
      Get.snackbar(
        'Success',
        'Logged out successfully',
        backgroundColor: teal, // soft teal background
        colorText: teal, // text color teal
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );

      // Navigate to login screen if needed
      // Get.offAll(() => LoginScreen());
    } catch (e) {
      // Error Snackbar
      Get.snackbar(
        'Error',
        'Logout failed',
        backgroundColor: teal,
        colorText: teal,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
