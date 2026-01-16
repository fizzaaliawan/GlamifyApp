import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/profile/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel controller = Get.find<ProfileViewModel>();
    const teal = Color(0xFF008080);

    Widget buildRow(IconData icon, String title, VoidCallback onTap) {
      return ListTile(
        leading: Icon(icon, color: teal),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: teal,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: teal,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 40, 39, 39),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Obx(() {
                    final Uint8List? img = controller.avatarFile.value;
                    return CircleAvatar(
                      radius: 38,
                      backgroundImage: img != null
                          ? MemoryImage(img)
                          : const AssetImage(
                              'assets/images/default-avatar.jpg',
                            ),
                    );
                  }),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.username.value,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.email.value,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: controller.openEditProfile,
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    child: const Text(
                      'Edit',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 1,
              child: Column(
                children: [
                  buildRow(
                    Icons.person_outline,
                    "Your Profile",
                    controller.openEditProfile,
                  ),
                  const Divider(height: 1),
                  buildRow(
                    Icons.payment,
                    "Payment Methods",
                    controller.openPayment,
                  ),
                  const Divider(height: 1),
                  buildRow(
                    Icons.help_outline,
                    "Help Center",
                    controller.openHelp,
                  ),
                  const Divider(height: 1),
                  buildRow(
                    Icons.logout,
                    "Log Out",
                    controller.showLogoutDialog,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
