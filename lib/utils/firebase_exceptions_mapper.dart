// lib/utils/firebase_exceptions_mapper.dart
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptions {
  static String getMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'Email already in use.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Contact support.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      default:
        return e.message ?? 'Authentication error: ${e.code}';
    }
  }
}
