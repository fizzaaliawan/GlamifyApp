import 'package:app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/main/service_detail_view_model.dart';
import '../../view_models/booking/booking_view_model.dart';
// ignore: unused_import
import '../booking/add_card_screen.dart';

class BookingScreen extends StatelessWidget {
  final String title;
  final String? image;
  final String selectedSpecialist;
  final ServiceDetailViewModel? serviceController;

  // ✅ Remove const because we are initializing a non-const field
  BookingScreen({
    super.key,
    required this.title,
    required this.selectedSpecialist,
    this.image,
    this.serviceController,
  });

  // ✅ Non-const initialization
  final BookingViewModel viewModel = Get.put(BookingViewModel());

  Null get date => null;

  Null get time => null;

  @override
  Widget build(BuildContext context) {
    const Color teal = Color(0xFF008080);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: teal,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: teal,
              ),
            ),
            const SizedBox(height: 12),

            // Date selection grid
            GridView.builder(
              itemCount: 31,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                int day = index + 1;
                return Obx(() {
                  bool isSelected = viewModel.selectedDate.value.day == day;
                  return GestureDetector(
                    onTap: () {
                      viewModel.setDate(
                        DateTime(
                          viewModel.selectedDate.value.year,
                          viewModel.selectedDate.value.month,
                          day,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? teal : Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$day',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),

            const SizedBox(height: 30),
            const Text(
              'Available Slot',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: teal,
              ),
            ),
            const SizedBox(height: 12),

            // Time slots
            GridView.builder(
              itemCount: viewModel.timeSlots.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2.2,
              ),
              itemBuilder: (context, index) {
                String slot = viewModel.timeSlots[index];
                return Obx(() {
                  bool isSelected = viewModel.selectedTime.value == slot;
                  return GestureDetector(
                    onTap: () => viewModel.setTime(slot),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? teal : Colors.white,
                        border: Border.all(
                          color: isSelected ? teal : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        slot,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),

            const SizedBox(height: 30),

            // Book Appointment Button
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: viewModel.isValid
                      ? () {
                          // Navigate to AddCardScreen safely
                          Get.toNamed(
                            AppRoutes.addCard,
                            arguments: {
                              'title': title,
                              'date': date,
                              'time': time,
                              'selectedSpecialist': selectedSpecialist,
                            },
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Book Appointment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
