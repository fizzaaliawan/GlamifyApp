import 'package:get/get.dart';
import '../../view_models/main/home_view_model.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeViewModel());
  }
}
