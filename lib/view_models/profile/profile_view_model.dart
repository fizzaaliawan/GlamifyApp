import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_models/profile/edit_profile_view_model.dart';
import '../../views/profile/edit_profile_screen.dart';
import '../../views/booking/add_card_screen.dart';
import '../../views/others/help_center_screen.dart';
import '../../views/auth/signin_screen.dart';

class ProfileViewModel extends GetxController {
  final username = "Fizza Ali".obs;
  final email = "fizza@example.com".obs;
  final avatarFile = Rx<Uint8List?>(null);

  Future<void> openEditProfile() async {
    if (!Get.isRegistered<EditProfileViewModel>()) {
      Get.put(EditProfileViewModel());
    }

    final result = await Get.to(() => EditProfileScreen());

    if (result != null && result is Map<String, dynamic>) {
      username.value = result['name'] ?? username.value;
      email.value = result['email'] ?? email.value;
      avatarFile.value = result['avatar'] ?? avatarFile.value;
    }
  }

  void openPayment() {
    Get.to(
      () => AddCardScreen(
        title: 'Service Name',
        price: 50.0,
        date: DateTime.now(),
        time: '10:00 AM',
        selectedSpecialist: 'Stylist Name',
      ),
    );
  }

  void openHelp() {
    Get.to(() => const HelpCenterScreen());
  }

  void showLogoutDialog() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to log out?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.offAll(() => SignInScreen());
      },
    );
  }
}
