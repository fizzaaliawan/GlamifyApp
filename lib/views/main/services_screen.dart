import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/main/services_view_model.dart';
import '../../view_models/main/service_detail_view_model.dart';
import 'service_detail_screen.dart';

class ServicesScreen extends StatelessWidget {
  final String categoryName;
  const ServicesScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Inject ServicesViewModel
    final controller = Get.put(ServicesViewModel(categoryName: categoryName));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(categoryName, style: const TextStyle(color: Colors.teal)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => controller.filteredServices.isEmpty
              ? const Center(
                  child: Text(
                    "No services available.",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : GridView.builder(
                  itemCount: controller.filteredServices.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (context, index) {
                    final s = controller.filteredServices[index];

                    return GestureDetector(
                      onTap: () {
                        // Initialize ServiceDetailViewModel before navigating
                        final serviceController = ServiceDetailViewModel(
                          serviceName: s["name"].toString(),
                          price: s["price"] as int,
                          image:
                              "assets/images/services/${s["image"].toString()}",
                        );

                        // Navigate to ServiceDetailScreen passing the controller
                        Get.to(
                          () => ServiceDetailScreen(
                            controller: serviceController,
                          ),
                        );
                      },

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              "assets/images/services/${s["image"].toString()}",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 120,
                                  width: double.infinity,
                                  color: Colors.grey.shade300,
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            s["name"].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "\$${s["price"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF008080),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
