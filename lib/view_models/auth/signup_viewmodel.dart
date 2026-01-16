import 'dart:ui';

import 'package:get/get.dart';
import '../../data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpViewModel extends GetxController {
  final AuthService _authService = AuthService();

  RxBool isLoading = false.obs;
  Rx<User?> user = Rx<User?>(null);

  // ✅ Add optional role parameter
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    String role = 'customer', // default role
  }) async {
    try {
      isLoading.value = true;

      final newUser = await _authService.signUp(
        name: name,
        email: email,
        password: password,
        role: role, // <-- pass role here
      );

      user.value = newUser;

      Get.snackbar(
        "Success",
        "Account created! Check your email to verify.",
        backgroundColor: const Color(0xFF4CAF50),
        colorText: const Color(0xFFFFFFFF),
      );

      return true;
    } catch (e, s) {
      Get.log("SignUp Error: $e\n$s");

      Get.snackbar(
        "Error",
        "Failed to sign up. Please try again.",
        backgroundColor: const Color(0xFFF44336),
        colorText: const Color(0xFFFFFFFF),
      );

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  User? get currentUser => user.value;
}
