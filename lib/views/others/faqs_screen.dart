import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/others/faq_view_model.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the ViewModel
    final controller = Get.put(FAQViewModel());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF008080),
        title: const Text('FAQs', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.faqs.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final faq = controller.faqs[index];
            return ExpansionTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              backgroundColor: Colors.grey.withAlpha(25),
              collapsedBackgroundColor: Colors.grey.withAlpha(25),
              title: Text(
                faq['question']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF008080),
                ),
              ),
              children: [
                Text(
                  faq['answer']!,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
