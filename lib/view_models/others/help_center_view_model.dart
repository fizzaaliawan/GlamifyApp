import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/others/faqs_screen.dart';
import '../../views/others/contact_support_screen.dart';

class HelpCenterViewModel extends GetxController {
  static const Color teal = Color(0xFF008080);

  // Navigation actions
  void goToFAQs() {
    Get.to(() => const FAQScreen());
  }

  void goToContactSupport() {
    Get.to(() => const ContactSupportScreen());
  }

  void showAboutApp(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: "Glamify",
      applicationVersion: "1.0.0",
      applicationIcon: const Icon(Icons.favorite, color: teal),
      children: const [
        Text("This app helps users book beauty services easily."),
      ],
    );
  }
}
