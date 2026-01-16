import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../views/booking/booking_screen.dart';
import '../../views/others/notifications_screen.dart';
import '../../views/main/categories_screen.dart';
import '../../core/routes/app_routes.dart';

class HomeViewModel extends GetxController {
  // Bottom Navigation Index
  RxInt selectedIndex = 0.obs;

  // User role
  RxString userRole = ''.obs; // <-- added

  // Search field
  RxString searchQuery = ''.obs;

  // Price filter value
  RxDouble maxPrice = 15000.0.obs;

  // Categories (Static)
  final RxList<Map<String, String>> categories = [
    {"name": "Haircuts", "image": "assets/images/categories/haircut.jpg"},
    {"name": "Facials", "image": "assets/images/categories/facial.png"},
    {"name": "Manicures", "image": "assets/images/categories/manicure.jpg"},
    {"name": "Massages", "image": "assets/images/categories/massage.jpg"},
  ].obs;

  // Exclusive Packages (Static)
  final RxList<Map<String, dynamic>> packages = [
    {
      'title': 'Luxury Hair Spa',
      'price': 2500,
      'imagePath': 'assets/images/packages/package1.jpg',
    },
    {
      'title': 'Bridal Makeup',
      'price': 12000,
      'imagePath': 'assets/images/packages/package2.jpeg',
    },
    {
      'title': 'Relaxing Massage',
      'price': 3000,
      'imagePath': 'assets/images/packages/package3.jpg',
    },
    {
      'title': 'Manicure & Pedicure',
      'price': 2000,
      'imagePath': 'assets/images/packages/package4.jpg',
    },
  ].obs;

  // Filtered Packages (Reactive)
  RxList<Map<String, dynamic>> filteredPackages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredPackages.assignAll(packages);

    // Load user role from Firestore
    fetchUserRole();

    // React to search query and maxPrice changes
    ever(searchQuery, (_) => _applyFilters());
    ever(maxPrice, (_) => _applyFilters());
  }

  Future<void> fetchUserRole() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        if (doc.exists && doc.data() != null) {
          userRole.value = doc.data()?['role'] ?? 'customer';
        }
      }
    } catch (e) {
      Get.log('Error fetching user role: $e');
      userRole.value = 'customer';
    }
  }

  void _applyFilters() {
    final query = searchQuery.value.toLowerCase();
    final max = maxPrice.value;

    final results = packages.where((pkg) {
      final title = (pkg['title'] ?? '').toString().toLowerCase();
      final price = (pkg['price'] ?? 0) as int;
      return title.contains(query) && price <= max;
    }).toList();

    filteredPackages.assignAll(results);
  }

  void setSelectedIndex(int index) => selectedIndex.value = index;
  void setSearchQuery(String query) => searchQuery.value = query;
  void setMaxPrice(double price) => maxPrice.value = price;

  /// Navigation Methods
  void navigateTo(int index) {
    setSelectedIndex(index);
    switch (index) {
      case 1:
        Get.to(
          () => BookingScreen(
            title: "Book Service",
            selectedSpecialist: '',
            serviceController: null,
          ),
        );
        break;
      case 2:
        Get.to(() => NotificationScreen(onRead: () {}));
        break;
      case 3:
        Get.toNamed(AppRoutes.profile);
        break;
    }
  }

  void navigateToCategories() {
    Get.to(() => CategoriesScreen());
  }
}
