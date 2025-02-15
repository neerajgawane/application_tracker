import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/application.dart';

class ApplicationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Application>> getUserApplications(String userId) async {
    final snapshot = await _firestore
        .collection('applications')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id; // Ensure the document ID is included
      return Application.fromMap(data);
    }).toList();
  }

  Future<void> updateApplicationStatus(
      String applicationId, String status, double progress) async {
    try {
      await _firestore.collection('applications').doc(applicationId).update({
        'status': status,
        'progress': progress,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating application: $e');
      throw e;
    }
  }

  Future<void> addApplication(String userId, Application application) async {
    try {
      await _firestore.collection('applications').add({
        ...application.toMap(),
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding application: $e');
      throw e;
    }
  }
}