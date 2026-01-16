import 'package:get/get.dart';
import '../../view_models/auth/signin_viewmodel.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInViewModel>(() => SignInViewModel());
  }
}
