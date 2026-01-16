import 'package:get/get.dart';
import '../../view_models/booking/add_card_viewmodel.dart';

class AddCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCardViewModel>(() => AddCardViewModel());
  }
}
