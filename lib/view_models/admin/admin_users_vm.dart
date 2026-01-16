import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/adminusers_repo.dart';

class AdminUsersVM extends GetxController {
  final UsersRepo _repo = UsersRepo();

  var users = <UserModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _repo.streamUsers().listen((data) {
      users.value = data;
      isLoading.value = false;
    });
  }

  Future<void> changeUserRole(String id, String role) async {
    await _repo.updateUserRole(id, role);
  }

  Future<void> deleteUser(String id) async {
    await _repo.deleteUser(id);
  }
}
