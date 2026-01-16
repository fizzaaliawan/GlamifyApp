import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/admincategories_repo.dart';

class AdminCategoriesVM extends GetxController {
  final CategoriesRepo _repo = CategoriesRepo();

  var categories = <CategoryModel>[].obs;
  var isLoading = true.obs;

  var nameController = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _listenCategories();
  }

  void _listenCategories() {
    _repo.streamCategories().listen((data) {
      categories.value = data;
      isLoading.value = false;
    });
  }

  void clearForm() => nameController.value = '';

  void setForm(CategoryModel? category) {
    if (category != null) {
      nameController.value = category.name;
    } else {
      clearForm();
    }
  }

  Future<void> saveCategory({String? id}) async {
    final name = nameController.value.trim();
    if (name.isEmpty) {
      Get.snackbar(
        'Error',
        'Name cannot be empty',
        backgroundColor: const Color(0xFFB00020),
        colorText: Colors.white,
      );
      return;
    }

    final category = CategoryModel(id: id ?? '', name: name);

    if (id == null) {
      await _repo.addCategory(category);
    } else {
      await _repo.updateCategory(category);
    }

    clearForm();
    Get.back();
  }

  Future<void> deleteCategory(String id) async {
    await _repo.deleteCategory(id);
  }
}
