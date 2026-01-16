// File: lib/view_models/admin/admin_viewmodel.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminViewModel extends GetxController {
  var isLoading = false.obs;

  var users = <Map<String, dynamic>>[].obs;
  var services = <Map<String, dynamic>>[].obs;
  var categories = <Map<String, dynamic>>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== USERS ====================
  void fetchUsers() async {
    isLoading.value = true;
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      users.value = snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } finally {
      isLoading.value = false;
    }
  }

  void addUser(Map<String, dynamic> data) async {
    await _firestore.collection('users').add(data);
    fetchUsers();
  }

  void updateUser(String id, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(id).update(data);
    fetchUsers();
  }

  void deleteUser(String id) async {
    await _firestore.collection('users').doc(id).delete();
    fetchUsers();
  }

  // ==================== SERVICES ====================
  void fetchServices() async {
    isLoading.value = true;
    try {
      QuerySnapshot snapshot = await _firestore.collection('services').get();
      services.value = snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } finally {
      isLoading.value = false;
    }
  }

  void addService(Map<String, dynamic> data) async {
    await _firestore.collection('services').add(data);
    fetchServices();
  }

  void updateService(String id, Map<String, dynamic> data) async {
    await _firestore.collection('services').doc(id).update(data);
    fetchServices();
  }

  void deleteService(String id) async {
    await _firestore.collection('services').doc(id).delete();
    fetchServices();
  }

  // ==================== CATEGORIES ====================
  void fetchCategories() async {
    isLoading.value = true;
    try {
      QuerySnapshot snapshot = await _firestore.collection('categories').get();
      categories.value = snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } finally {
      isLoading.value = false;
    }
  }

  void addCategory(Map<String, dynamic> data) async {
    await _firestore.collection('categories').add(data);
    fetchCategories();
  }

  void updateCategory(String id, Map<String, dynamic> data) async {
    await _firestore.collection('categories').doc(id).update(data);
    fetchCategories();
  }

  void deleteCategory(String id) async {
    await _firestore.collection('categories').doc(id).delete();
    fetchCategories();
  }
}
