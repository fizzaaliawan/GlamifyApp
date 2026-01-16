// File: lib/bindings/admin/admin_binding.dart
import 'package:get/get.dart';
import '../../view_models/admin/admin_view_model.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminViewModel>(() => AdminViewModel());
  }
}
