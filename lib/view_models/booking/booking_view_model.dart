import 'package:get/get.dart';

class BookingViewModel extends GetxController {
  // Selected states
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedTime = ''.obs;

  // Time slots
  final List<String> timeSlots = [
    '9:30-10:30 AM',
    '10:30-11:45 AM',
    '12:00-1:30 PM',
    '2:00-4:30 PM',
    '5:30-6:30 PM',
    '6:30-7:30 PM',
  ];

  // Update selected date
  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  // Update time slot
  void setTime(String time) {
    selectedTime.value = time;
  }

  // For button enable/disable
  bool get isValid => selectedTime.value.isNotEmpty;
}
