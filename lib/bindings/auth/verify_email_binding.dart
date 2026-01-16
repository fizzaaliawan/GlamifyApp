import 'package:get/get.dart';
import '../../view_models/auth/verify_email_viewmodel.dart';

class VerifyEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyEmailViewModel>(() => VerifyEmailViewModel());
  }
}
