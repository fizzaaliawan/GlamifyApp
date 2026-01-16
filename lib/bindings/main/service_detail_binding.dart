import 'package:get/get.dart';
import '../../view_models/main/service_detail_view_model.dart';

class ServiceDetailBinding extends Bindings {
  final String serviceName;
  final int price;
  final String image;
  final double rating;
  final String description;

  ServiceDetailBinding({
    required this.serviceName,
    required this.price,
    required this.image,
    this.rating = 4.5,
    this.description = "",
  });

  @override
  void dependencies() {
    Get.lazyPut<ServiceDetailViewModel>(() => ServiceDetailViewModel(
          serviceName: serviceName,
          price: price,
          image: image,
          rating: rating,
          description:
              description.isEmpty ? "No description available" : description,
        ));
  }
}
