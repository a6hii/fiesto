import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthFirebaseProvider {
  final FirebaseAuth _firebaseAuth;

  PhoneAuthFirebaseProvider({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  Future<void> verifyPhoneNumber({
    required String mobileNumber,
    required onVerificationCompleted,
    required onVerificaitonFailed,
    required onCodeSent,
    required onCodeAutoRetrievalTimeOut,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificaitonFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeOut,
      //timeout: const Duration(seconds: 5),
    );
  }

  Future<User?> loginWithSMSVerificationCode(
      {required String verificationId,
      required String smsVerficationcode}) async {
    final AuthCredential credential = _getAuthCredentialFromVerificationCode(
        verificationId: verificationId, verificationCode: smsVerficationcode);
    return await authenticationWithCredential(credential: credential);
  }

  Future<User?> authenticationWithCredential(
      {required AuthCredential credential}) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    if (userCredential.user != null) {
      final uid = userCredential.user!.uid;
      final userSanp =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (!userSanp.exists) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'uid': uid,
          'phone': userCredential.user!.phoneNumber,
          'createdAt': DateTime.now(),
          'name': '',
          'email': '',
          'city': '',
        });
      }
      //   return uid;
      // } else {
      //   return null;
    }
    return userCredential.user;
  }

  AuthCredential _getAuthCredentialFromVerificationCode(
      {required String verificationId, required String verificationCode}) {
    return PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: verificationCode,
    );
  }

  Stream<User?> getAuthStates() {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
