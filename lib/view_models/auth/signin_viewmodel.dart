import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../views/admin/admin_home_screen.dart';
import '../../core/routes/app_routes.dart';

class SignInViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  Future<void> signInAndRedirect({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = cred.user;
      if (user == null) return;

      final doc = await _firestore.collection('users').doc(user.uid).get();

      final role = doc.data()?['role'] ?? 'customer';

      if (role == 'admin') {
        // Navigate directly to AdminHomeScreen for CRUD
        Get.offAll(() => const AdminHomeScreen());
      } else {
        // Normal user
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
