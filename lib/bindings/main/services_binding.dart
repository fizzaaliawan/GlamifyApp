import 'package:get/get.dart';
import '../../view_models/main/services_view_model.dart';

class ServicesBinding extends Bindings {
  final String categoryName;

  ServicesBinding({required this.categoryName});

  @override
  void dependencies() {
    Get.lazyPut<ServicesViewModel>(
        () => ServicesViewModel(categoryName: categoryName));
  }
}
