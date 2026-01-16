import 'package:get/get.dart';

class SavedViewModel extends GetxController {
  // Categories
  final List<String> categories = const [
    'All',
    'Haircuts',
    'Makeup',
    'Massage',
  ];

  // Selected filter index
  final RxInt selectedFilter = 0.obs;

  // Saved items
  final RxList<Map<String, String>> savedItems = <Map<String, String>>[
    {
      'title': "Men's Hair Cut",
      'subtitle': 'Prime Cuts & Styles · 4.5',
      'category': 'Haircuts',
      'image':
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800',
    },
    {
      'title': 'Classic Touch Salon',
      'subtitle': 'Hair Coloring · 4.6',
      'category': 'Haircuts',
      'image':
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800',
    },
    {
      'title': 'Serenity & Style Studio',
      'subtitle': 'Facial & Spa · 4.7',
      'category': 'Massage',
      'image':
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800',
    },
    {
      'title': 'Glam Beauty Makeup',
      'subtitle': 'Makeup Services · 4.8',
      'category': 'Makeup',
      'image':
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=800',
    },
  ].obs;

  // Reactive filtered items
  final RxList<Map<String, String>> filteredItems = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Update filtered items whenever savedItems or selectedFilter changes
    everAll([savedItems, selectedFilter], (_) => _updateFilteredItems());
    _updateFilteredItems();
  }

  void _updateFilteredItems() {
    if (selectedFilter.value == 0) {
      filteredItems.value = List.from(savedItems);
    } else {
      filteredItems.value = savedItems
          .where((item) => item['category'] == categories[selectedFilter.value])
          .toList();
    }
  }

  // Change filter
  void selectFilter(int index) {
    selectedFilter.value = index;
  }

  // Remove item
  void removeItem(Map<String, String> item) {
    savedItems.remove(item);
  }
}
