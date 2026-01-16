import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewPasswordViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  Future<void> updatePassword({required String newPassword}) async {
    try {
      isLoading.value = true;

      User? user = _auth.currentUser;

      if (user == null) {
        Get.snackbar("Error", "No user logged in");
        return;
      }

      await user.updatePassword(newPassword);

      Get.snackbar(
        "Success",
        "Password updated successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
