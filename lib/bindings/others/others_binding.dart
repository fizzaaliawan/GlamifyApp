import 'package:get/get.dart';

import '../../view_models/others/settings_view_model.dart';
import '../../view_models/others/notification_view_model.dart';
import '../../view_models/others/faq_view_model.dart';
import '../../view_models/others/help_center_view_model.dart';
import '../../view_models/others/contact_support_view_model.dart';
import '../../view_models/others/saved_view_model.dart';

class OthersBinding extends Bindings {
  @override
  void dependencies() {
    // Registering all "others" related view models
    Get.lazyPut<SettingsViewModel>(() => SettingsViewModel());
    Get.lazyPut<NotificationViewModel>(
      () => NotificationViewModel(
        onRead: () {},
      ),
    );
    Get.lazyPut<FAQViewModel>(() => FAQViewModel());
    Get.lazyPut<HelpCenterViewModel>(() => HelpCenterViewModel());
    Get.lazyPut<ContactSupportViewModel>(() => ContactSupportViewModel());
    Get.lazyPut<SavedViewModel>(() => SavedViewModel());
  }
}
