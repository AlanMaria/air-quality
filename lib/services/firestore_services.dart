import 'package:agri_hack/models/measures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, Measures>> getIdealMeasures(String crop) async {
    Measures _minMeasures = Measures();
    Measures _maxMeasures = Measures();
    try {} catch (e) {
      print("An exception occured: $e");
    }
    return {"min": _minMeasures, "max": _maxMeasures};
  }

  signupUserToDB(
      String uid, String user, String email, String krishibhavan) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        "name": user,
        "email": email,
        "krishibhavan": krishibhavan,
      });
      return "success";
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future<bool> checkForEmail(String email) async {
    try {
      var doc = await _firestore
          .collection('users')
          .where("email", isEqualTo: email)
          .get();
      if (doc.docs.isNotEmpty) {
        return true;
      }

      return false;
    } catch (e) {
      return true;
    }
  }

  Future<String> getKrishibhavan(String uid) async {
    try {
      var doc = await _firestore.collection('users').doc(uid).get();
      return doc.data()!["krishibhavan"];
    } catch (e) {
      print(e);
      return "ERROR";
    }
  }
}
