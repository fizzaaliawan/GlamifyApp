import 'package:get/get.dart';
import '../../view_models/booking/booking_view_model.dart';
import '../../view_models/booking/add_card_viewmodel.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingViewModel>(() => BookingViewModel());
    Get.lazyPut<AddCardViewModel>(() => AddCardViewModel());
  }
}

class BookingConfirmationViewModel {}
