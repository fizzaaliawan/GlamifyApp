import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UsersRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<UserModel>> streamUsers() {
    return _firestore
        .collection('users')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => UserModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> updateUserRole(String id, String role) async {
    await _firestore.collection('users').doc(id).update({'role': role});
  }

  Future<void> deleteUser(String id) async {
    await _firestore.collection('users').doc(id).delete();
  }
}
