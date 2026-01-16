import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingsViewModel extends GetxController {
  static const Color teal = Color(0xFF008080);

  // Reactive variables
  RxBool notifications = true.obs;
  RxBool darkMode = false.obs;
  RxString profileUrl = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Toggle functions
  void toggleNotifications(bool value) {
    notifications.value = value;
    _saveSetting('notifications', value);
  }

  void toggleDarkMode(bool value) {
    darkMode.value = value;
    _saveSetting('darkMode', value);
  }

  // Load settings from Firestore
  Future<void> loadUserSettings() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        final doc = await _firestore.collection('users').doc(uid).get();
        if (doc.exists) {
          notifications.value = doc['notifications'] ?? true;
          darkMode.value = doc['darkMode'] ?? false;
          profileUrl.value = doc['profileUrl'] ?? '';
        }
      }
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  // Save setting to Firestore
  Future<void> _saveSetting(String key, dynamic value) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        await _firestore
            .collection('users')
            .doc(uid)
            .set({key: value}, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint('Error saving $key: $e');
    }
  }

  // Upload profile picture to Firebase Storage
  Future<void> uploadProfilePicture(String filePath) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        final ref = _storage.ref().child('profile_pictures/$uid.jpg');
        await ref.putFile(File(filePath));
        profileUrl.value = await ref.getDownloadURL();
        await _firestore
            .collection('users')
            .doc(uid)
            .set({'profileUrl': profileUrl.value}, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint('Error uploading profile picture: $e');
    }
  }
}
