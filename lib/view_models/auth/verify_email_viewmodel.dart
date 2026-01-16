import 'package:get/get.dart';

class VerifyEmailViewModel extends GetxController {
  RxBool isLoading = false.obs;

  // Simulate sending email verification
  Future<void> sendEmailNotification() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1)); // simulate API call
    } finally {
      isLoading.value = false;
    }
  }
}
