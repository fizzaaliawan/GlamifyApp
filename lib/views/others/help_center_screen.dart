import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/others/help_center_view_model.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpCenterViewModel());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Help Center",
          style: TextStyle(
            color: HelpCenterViewModel.teal,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How can we help you?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildTile(
                context, Icons.question_answer, "FAQs", controller.goToFAQs),
            _buildTile(context, Icons.support_agent, "Contact Support",
                controller.goToContactSupport),
            _buildTile(context, Icons.info_outline, "About App",
                () => controller.showAboutApp(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 6),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: HelpCenterViewModel.teal),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
