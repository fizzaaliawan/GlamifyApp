import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/others/contact_support_view_model.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactSupportViewModel());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Contact Support",
          style: TextStyle(
            color: ContactSupportViewModel.teal,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              // ---------- Name ----------
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person,
                      color: ContactSupportViewModel.teal),
                  labelText: "Your Name",
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter your name" : null,
              ),
              const SizedBox(height: 16),

              // ---------- Email ----------
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email,
                      color: ContactSupportViewModel.teal),
                  labelText: "Your Email",
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter your email" : null,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // ---------- Message ----------
              TextFormField(
                controller: controller.messageController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.message,
                      color: ContactSupportViewModel.teal),
                  labelText: "Message",
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                maxLines: 5,
                validator: (value) =>
                    value!.isEmpty ? "Please enter your message" : null,
              ),
              const SizedBox(height: 24),

              // ---------- Reactive Submit Button ----------
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isFormValid.value
                          ? ContactSupportViewModel.teal
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: ContactSupportViewModel.teal
                          .withAlpha((0.5 * 255).toInt()),
                    ),
                    onPressed: controller.isFormValid.value
                        ? controller.submitSupportRequest
                        : null,
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
