import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('Mật khẩu yếu');
      } else if (e.code == 'email-already-in-use') {
        throw ('Tài khoản đã tồn tại');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('Không tìm thấy tài khoản');
      } else if (e.code == 'wrong-password') {
        throw ('Mật khẩu sai');
      }
    }
  }

  signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
