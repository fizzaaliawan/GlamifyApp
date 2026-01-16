import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminServicesScreen extends StatefulWidget {
  const AdminServicesScreen({super.key});

  @override
  State<AdminServicesScreen> createState() => _AdminServicesScreenState();
}

class _AdminServicesScreenState extends State<AdminServicesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _addOrUpdateService({String? docId}) async {
    final name = _nameController.text.trim();
    final price = int.tryParse(_priceController.text.trim()) ?? 0;
    final desc = _descController.text.trim();
    final imageUrl = _imageUrlController.text.trim();

    if (name.isEmpty || price <= 0 || imageUrl.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields and provide an image URL',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final data = {
      'name': name,
      'price': price,
      'description': desc,
      'image': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    };

    if (docId == null) {
      await _firestore.collection('services').add(data);
    } else {
      await _firestore.collection('services').doc(docId).update(data);
    }

    _nameController.clear();
    _priceController.clear();
    _descController.clear();
    _imageUrlController.clear();
    Get.back();
  }

  void _showServiceDialog({DocumentSnapshot? doc}) {
    if (doc != null) {
      _nameController.text = doc['name'];
      _priceController.text = doc['price'].toString();
      _descController.text = doc['description'] ?? '';
      _imageUrlController.text = doc['image'] ?? '';
    } else {
      _imageUrlController.clear();
    }

    Get.defaultDialog(
      title: doc == null ? 'Add Service' : 'Edit Service',
      titleStyle: const TextStyle(
        fontFamily: 'Benne',
        fontWeight: FontWeight.bold,
        color: Colors.teal,
        fontSize: 20,
      ),
      content: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _priceController,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: _imageUrlController,
            decoration: const InputDecoration(
              labelText: 'Image URL (Cloudinary)',
            ),
          ),
          if (_imageUrlController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.network(_imageUrlController.text, height: 100),
            ),
        ],
      ),
      textConfirm: 'Save',
      onConfirm: () => _addOrUpdateService(docId: doc?.id),
      textCancel: 'Cancel',
    );
  }

  Future<void> _deleteService(String docId) async {
    await _firestore.collection('services').doc(docId).delete();
    Get.snackbar(
      'Deleted',
      'Service removed',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Services',
          style: TextStyle(color: Colors.white, fontFamily: 'Benne'),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showServiceDialog(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('services')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.teal),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No services found. Add some!'));
          }

          final services = snapshot.data!.docs;

          return ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final doc = services[index];
              return ListTile(
                leading: Image.network(
                  doc['image'] ?? 'https://via.placeholder.com/50',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  doc['name'],
                  style: const TextStyle(
                    fontFamily: 'Benne',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Price: \$${doc['price']}',
                  style: const TextStyle(fontFamily: 'Benne'),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => _showServiceDialog(doc: doc),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteService(doc.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
