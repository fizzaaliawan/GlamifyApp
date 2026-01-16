import 'package:get/get.dart';
import '../../view_models/main/categories_view_model.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesViewModel>(() => CategoriesViewModel());
  }
}
