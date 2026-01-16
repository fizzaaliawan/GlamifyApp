import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _service = AuthService();

  // ---------------- SIGN UP ----------------
  Future<UserModel?> signUp({
    required String name,
    required String email,
    required String password,
    required String role, // required role
  }) async {
    final User? firebaseUser = await _service.signUp(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    if (firebaseUser != null) {
      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName ?? name,
        role: role, // store role
      );
    }
    return null;
  }

  // ---------------- SIGN IN ----------------
  Future<UserModel?> signIn({
    required String email,
    required String password,
    required String role, // required role
  }) async {
    final User? firebaseUser = await _service.signIn(
      email: email,
      password: password,
      role: role,
    );

    if (firebaseUser != null) {
      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName ?? '',
        role: role, // store role
      );
    }
    return null;
  }

  // ---------------- SIGN OUT ----------------
  Future<void> logout() async {
    await _service.signOut();
  }

  // ---------------- PASSWORD RESET ----------------
  Future<void> resetPassword(String email) async {
    await _service.sendPasswordResetEmail(email: email);
  }

  // ---------------- VERIFY OTP / CODE ----------------
  Future<bool> verifyCode(String code) async {
    return await _service.verifyOtp(code: code);
  }

  // ---------------- SET NEW PASSWORD ----------------
  Future<void> setNewPassword(String newPassword) async {
    await _service.updatePassword(newPassword: newPassword);
  }

  // ---------------- CURRENT USER ----------------
  UserModel? get currentUser {
    final user = _service.currentUser;
    if (user != null) {
      // Here, you may need to fetch role from Firestore if it's stored separately
      // For now, we'll default to 'user' if not provided
      return UserModel(
        id: user.uid,
        email: user.email!,
        name: user.displayName ?? '',
        role: 'user',
      );
    }
    return null;
  }
}
