import 'package:get/get.dart';

// ================== VIEW MODELS ==================
import 'package:app/view_models/main/service_detail_view_model.dart';

// ================== AUTH SCREENS ==================
import '../../views/auth/splash_screen.dart';
import '../../views/auth/onboarding_screen.dart';
import '../../views/auth/signin_screen.dart';
import '../../views/auth/signup_screen.dart';
import '../../views/auth/forgot_password_screen.dart';
import '../../views/auth/verify_email_screen.dart';
import '../../views/auth/logout_screen.dart';

// ================== MAIN SCREENS ==================
import '../../views/main/home_screen.dart';
import '../../views/main/services_screen.dart';
import '../../views/main/categories_screen.dart';
import '../../views/main/service_detail_screen.dart';

// ================== BOOKING SCREENS ==================
import '../../views/booking/booking_screen.dart';
import '../../views/booking/add_card_screen.dart';

// ================== PROFILE SCREENS ==================
import '../../views/profile/profile_screen.dart';
import '../../views/profile/edit_profile_screen.dart';

// ================== OTHER SCREENS ==================
import '../../views/others/notifications_screen.dart';
import '../../views/others/faqs_screen.dart';
import '../../views/others/contact_support_screen.dart';
import '../../views/others/help_center_screen.dart';

// ================== ADMIN SCREENS ==================
import '../../views/admin/admin_home_screen.dart';
import '../../views/admin/admin_services_screen.dart';

// ================== BINDINGS ==================
import '../../bindings/auth/signin_binding.dart';
import '../../bindings/auth/signup_binding.dart';
import '../../bindings/auth/forgot_password_binding.dart';
import '../../bindings/auth/verify_email_binding.dart';

import '../../bindings/main/home_bindings.dart';
import '../../bindings/main/categories_binding.dart';

import '../../bindings/booking/booking_binding.dart';
import '../../bindings/booking/add_card_binding.dart';

import '../../bindings/profile/profile_binding.dart';
import '../../bindings/profile/edit_profile_binding.dart';

import '../../bindings/others/others_binding.dart';
import '../../bindings/admin/admin_binding.dart';

class AppRoutes {
  // ================== ROUTE NAMES ==================
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const signin = '/signin';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const verifyEmail = '/verify-email';
  static const logout = '/logout';

  static const home = '/home';
  static const services = '/services';
  static const categories = '/categories';
  static const serviceDetail = '/service-detail';

  static const booking = '/booking';
  static const addCard = '/add-card';
  static const bookingConfirmation = '/booking-confirmation';

  static const profile = '/profile';
  static const editProfile = '/edit-profile';

  static const notifications = '/notifications';
  static const faqs = '/faqs';
  static const contactSupport = '/contact-support';
  static const helpCenter = '/help-center';

  static const adminHome = '/admin-home';
  static const manageServices = '/admin-manage-services';

  // ================== ROUTES ==================
  static final routes = <GetPage>[
    // -------- AUTH --------
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: signin, page: () => SignInScreen(), binding: SignInBinding()),
    GetPage(name: signup, page: () => SignUpScreen(), binding: SignUpBinding()),
    GetPage(
      name: forgotPassword,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: verifyEmail,
      page: () => VerifyEmailScreen(email: Get.arguments as String? ?? ''),
      binding: VerifyEmailBinding(),
    ),
    GetPage(name: logout, page: () => LogoutScreen()),

    // -------- MAIN --------
    GetPage(name: home, page: () => HomeScreen(), binding: HomeBindings()),
    GetPage(
      name: services,
      page: () => ServicesScreen(categoryName: Get.arguments as String? ?? ''),
      binding: HomeBindings(),
    ),
    GetPage(
      name: categories,
      page: () => CategoriesScreen(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: serviceDetail,
      page: () {
        final controller = Get.arguments as ServiceDetailViewModel?;
        return ServiceDetailScreen(
          controller:
              controller ??
              ServiceDetailViewModel(
                serviceName: 'Service',
                price: 0,
                image: 'images/services/default.png',
              ),
        );
      },
      binding: HomeBindings(),
    ),

    // -------- BOOKING --------
    GetPage(
      name: booking,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};
        final controller = args['serviceController'] as ServiceDetailViewModel;

        return BookingScreen(
          title: args['title'] ?? controller.serviceName,
          image: args['image'] ?? controller.image,
          selectedSpecialist: args['selectedSpecialist'] ?? '',
          serviceController: controller,
        );
      },
      binding: BookingBinding(),
    ),
    GetPage(
      name: addCard,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};
        return AddCardScreen(
          title:
              args['title'] ?? '', // <-- remove if AddCardScreen has no title
          price: args['price'] as double? ?? 0.0,
          date: args['date'] as DateTime? ?? DateTime.now(),
          time: args['time'] ?? '',
          selectedSpecialist: args['selectedSpecialist'] ?? '',
        );
      },
      binding: AddCardBinding(),
    ),

    // -------- PROFILE --------
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: editProfile,
      page: () => EditProfileScreen(),
      binding: EditProfileBinding(),
    ),

    // -------- OTHERS --------
    GetPage(
      name: notifications,
      page: () => NotificationScreen(onRead: () {}),
      binding: OthersBinding(),
    ),
    GetPage(name: faqs, page: () => FAQScreen(), binding: OthersBinding()),
    GetPage(
      name: contactSupport,
      page: () => ContactSupportScreen(),
      binding: OthersBinding(),
    ),
    GetPage(
      name: helpCenter,
      page: () => HelpCenterScreen(),
      binding: OthersBinding(),
    ),

    // -------- ADMIN --------
    GetPage(
      name: adminHome,
      page: () => const AdminHomeScreen(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: manageServices,
      page: () => const AdminServicesScreen(),
      binding: AdminBinding(),
    ),
  ];
}
