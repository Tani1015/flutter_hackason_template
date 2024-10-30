import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();

  static FirebaseAuthHelper get instance => _instance;
  static final _instance = FirebaseAuthHelper._();

  static final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential> signInWithCustomToken(String token) async {
    return _auth.signInWithCustomToken(token);
  }

  Future<UserCredential> signInAnonymously() async {
    return _auth.signInAnonymously();
  }

  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> updateEmail(String email) async {
    await currentUser?.verifyBeforeUpdateEmail(email);
  }

  Future<void> delete(User user) => user.delete();
}
