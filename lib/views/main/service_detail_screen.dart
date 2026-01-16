import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/main/service_detail_view_model.dart';
import '../booking/booking_screen.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceDetailViewModel controller;

  const ServiceDetailScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Widget buildRatingStars(double rating) {
      List<Widget> stars = [];
      for (int i = 1; i <= 5; i++) {
        if (rating >= i) {
          stars.add(const Icon(Icons.star, color: Colors.amber, size: 20));
        } else if (rating >= i - 0.5) {
          stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 20));
        } else {
          stars.add(
            const Icon(Icons.star_border, color: Colors.amber, size: 20),
          );
        }
      }
      return Row(children: stars);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.serviceName,
          style: const TextStyle(color: ServiceDetailViewModel.teal),
        ),
        backgroundColor: Colors.white,
        foregroundColor: ServiceDetailViewModel.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                controller.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              controller.serviceName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              "\$ ${controller.price}",
              style: const TextStyle(
                fontSize: 20,
                color: ServiceDetailViewModel.teal,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                buildRatingStars(controller.rating),
                const SizedBox(width: 8),
                Text("(${controller.rating})"),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Select Stylist:",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return Row(
                children: List.generate(controller.stylists.length, (index) {
                  final selected =
                      index == controller.selectedStylistIndex.value;
                  return GestureDetector(
                    onTap: () => controller.selectStylist(index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? ServiceDetailViewModel.teal
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        controller.stylists[index],
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
            const SizedBox(height: 16),
            const Text(
              "About Service:",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              controller.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                final stylist =
                    controller.stylists[controller.selectedStylistIndex.value];
                Get.to(
                  () => BookingScreen(
                    serviceController: controller,
                    selectedSpecialist: stylist,
                    title: '',
                  ),
                );
              },
              icon: const Icon(Icons.calendar_today),
              label: const Text("Book Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: ServiceDetailViewModel.teal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
