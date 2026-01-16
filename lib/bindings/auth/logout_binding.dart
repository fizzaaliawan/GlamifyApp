import 'package:get/get.dart';
import '../../view_models/auth/logout_viewmodel.dart';

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogoutViewModel>(() => LogoutViewModel());
  }
}
