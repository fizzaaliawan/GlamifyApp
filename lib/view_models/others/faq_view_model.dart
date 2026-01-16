import 'package:get/get.dart';

class FAQViewModel extends GetxController {
  // List of FAQs
  final faqs = <Map<String, String>>[
    {
      'question': 'How do I edit my profile?',
      'answer': 'Go to Profile > My Profile and update your information.'
    },
    {
      'question': 'How can I change my payment method?',
      'answer':
          'You can add, edit, or remove payment methods in the Payment Methods screen.'
    },
    {
      'question': 'How do I save my favorite services?',
      'answer':
          'Tap the heart icon on any service page to save it to your Saved list.'
    },
    {
      'question': 'I forgot my password. What should I do?',
      'answer':
          'Tap “Forgot Password” on the login screen to reset your password.'
    },
    {
      'question': 'How can I contact support?',
      'answer': 'You can reach us through Help Center > Contact Support.'
    },
  ].obs; // Observable list (if you plan to modify it dynamically)
}
