import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactSupportViewModel extends GetxController {
  static const Color teal = Color(0xFF008080);

  final formKey = GlobalKey<FormState>();

  // Text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  // Reactive variable to track form validity
  final isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Listen to text changes to validate form
    nameController.addListener(validateForm);
    emailController.addListener(validateForm);
    messageController.addListener(validateForm);
  }

  // Validate form and update reactive variable
  void validateForm() {
    final isValid = nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        messageController.text.isNotEmpty;

    isFormValid.value = isValid;
  }

  // Function to submit the form
  void submitSupportRequest() {
    if (formKey.currentState!.validate()) {
      Get.snackbar(
        "Success",
        "Support request sent successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: teal,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );

      // Clear fields
      nameController.clear();
      emailController.clear();
      messageController.clear();
    }
  }

  @override
  void onClose() {
    // Dispose controllers
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
