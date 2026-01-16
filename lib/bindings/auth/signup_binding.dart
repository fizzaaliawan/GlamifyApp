import 'package:get/get.dart';
import '../../view_models/auth/signup_viewmodel.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpViewModel>(() => SignUpViewModel());
  }
}
