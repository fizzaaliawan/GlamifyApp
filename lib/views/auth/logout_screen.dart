import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/auth/logout_viewmodel.dart';

class LogoutScreen extends StatelessWidget {
  LogoutScreen({super.key});

  final LogoutViewModel logoutVM = Get.find<LogoutViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout', style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.teal),
      ),
      body: Center(
        child: Obx(
          () => logoutVM.isLoading.value
              ? const CircularProgressIndicator(color: Colors.teal)
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    logoutVM.logout();
                  },
                  child: const Text('Logout'),
                ),
        ),
      ),
    );
  }
}
