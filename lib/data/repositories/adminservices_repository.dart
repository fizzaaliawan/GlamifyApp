import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class AdminServicesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CloudinaryPublic _cloudinary =
      CloudinaryPublic('dmfi1adj2', 'unsigned_upload', cache: false);

  // ignore: non_constant_identifier_names
  Null get await_firestore => null;

  Stream<QuerySnapshot> getServices() => _firestore
      .collection('services')
      .orderBy('createdAt', descending: true)
      .snapshots();

  Future<String?> uploadImage(String path) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(path,
            resourceType: CloudinaryResourceType.Image),
      );
      return response.secureUrl;
    } catch (e) {
      throw Exception('Image upload failed');
    }
  }

  Future<void> addService(Map<String, dynamic> data) async =>
      await _firestore.collection('services').add(data);

  Future<void> updateService(String id, Map<String, dynamic> data) async =>
      await _firestore.collection('services').doc(id).update(data);

  Future<void> deleteService(String id) async =>
      await _firestore.collection('services').doc(id).delete();
}
