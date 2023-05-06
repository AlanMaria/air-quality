import 'package:agri_hack/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirestoreServices();

  Future<String> signUpUser(
      String name, String email, String password, String krishibhavan) async {
    String res = "Some error occured";

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.signupUserToDB(
          _auth.currentUser!.uid, name, email, krishibhavan);

      res = "success";
    } on FirebaseAuthException catch (fberror) {
      res = fberror.code;
    } catch (err) {
      res = err.toString();
      print(err.toString());
    }
    return res;
  }

  Future<String> loginUser(String email, String password) async {
    String res = "Some error occured";
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      res = "success";
    } catch (e) {
      res = "FAILED: ${e.toString()}";
    }
    return res;
  }

  Future<String> signoutUser() async {
    String res = "Some error occured";

    try {
      await _auth.signOut();
      res = "success";
    } on FirebaseAuthException catch (fberror) {
      res = fberror.code;
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
