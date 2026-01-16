import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/main/home_view_model.dart';
import '../../view_models/profile/profile_view_model.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel vm = Get.find<HomeViewModel>();
  final ProfileViewModel profileVM = Get.put(ProfileViewModel());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color teal = Color(0xFF008080);
    final homeCategories = vm.categories.take(2).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 50,
        title: const Text(
          'GLAMIFY',
          style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: teal),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // SEARCH + FILTER
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      onChanged: vm.setSearchQuery,
                      decoration: const InputDecoration(
                        hintText: 'Search services or packages',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: teal),
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => _showFilterSheet(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.tune, color: teal),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // BANNER
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/banner.jpg',
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Exclusive Packages',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: teal),
            ),
            const SizedBox(height: 16),

            // EXCLUSIVE PACKAGES LIST
            SizedBox(
              height: 200,
              child: Obx(() {
                final packages = vm.filteredPackages;

                if (packages.isEmpty) {
                  return const Center(child: Text('No packages found'));
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    final pkg = packages[index];
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(51),
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.asset(
                              pkg['imagePath'],
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(pkg['title'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text('Rs. ${pkg['price']}',
                                    style: const TextStyle(
                                        color: teal,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 24),

            // OUR SERVICES HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Our Services",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                TextButton(
                  onPressed: vm.navigateToCategories, // <-- See All
                  child: const Text("See All",
                      style:
                          TextStyle(color: teal, fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // CATEGORIES GRID
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final cat = homeCategories[index];
                return GestureDetector(
                  onTap: vm.navigateToCategories, // <-- Tap on any category
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        Image.asset(
                          cat['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Container(color: const Color.fromRGBO(0, 0, 0, 0.35)),
                        Center(
                          child: Text(cat['name']!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: teal,
            unselectedItemColor: Colors.grey,
            currentIndex: vm.selectedIndex.value,
            onTap: vm.navigateTo,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: 'Bookings'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notifications'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          )),
    );
  }

  void _showFilterSheet(BuildContext context) {
    double tempMaxPrice = vm.maxPrice.value;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSheet) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Filter by Price',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Slider(
                  value: tempMaxPrice,
                  min: 0,
                  max: 15000,
                  divisions: 30,
                  label: 'Rs ${tempMaxPrice.toInt()}',
                  activeColor: const Color(0xFF008080),
                  onChanged: (value) {
                    setStateSheet(() {
                      tempMaxPrice = (value / 500).round() * 500;
                    });
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('0'),
                    Text('Rs ${tempMaxPrice.toInt()}'),
                    const Text('15000'),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      vm.setMaxPrice(tempMaxPrice);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008080),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Apply Filter',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
