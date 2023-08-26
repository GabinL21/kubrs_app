import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> persistUser() async {
    final user = _firebaseAuth.currentUser!;
    final userDoc = _firebaseFirestore.collection('users').doc(user.uid);
    if ((await userDoc.get()).exists) return;
    final creationDateTime = DateTime.now();
    await userDoc.set({'name': user.displayName, 'creation': creationDateTime});
  }
}
