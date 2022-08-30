import 'package:fiesto/models/phone_auth.dart';
import 'package:fiesto/providers/phone_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthRepository {
  final PhoneAuthFirebaseProvider _phoneAuthFirebaseProvider;
  PhoneAuthRepository({
    required PhoneAuthFirebaseProvider phoneAuthFirebaseProvider,
  }) : _phoneAuthFirebaseProvider = phoneAuthFirebaseProvider;

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required onVerificationCompleted,
    required onVerificaitonFailed,
    required onCodeSent,
    required onCodeAutoRetrievalTimeOut,
  }) async {
    await _phoneAuthFirebaseProvider.verifyPhoneNumber(
        onCodeAutoRetrievalTimeOut: onCodeAutoRetrievalTimeOut,
        onCodeSent: onCodeSent,
        onVerificaitonFailed: onVerificaitonFailed,
        onVerificationCompleted: onVerificationCompleted,
        mobileNumber: phoneNumber);
  }

  Future<PhoneAuthModel> verifySMSCode({
    required String smsCode,
    required String verificationId,
  }) async {
    final User? user =
        await _phoneAuthFirebaseProvider.loginWithSMSVerificationCode(
            verificationId: verificationId, smsVerficationcode: smsCode);
    if (user != null) {
      return PhoneAuthModel(
        phoneAuthModelState: PhoneAuthModelState.verified,
        uid: user.uid,
      );
    } else {
      return PhoneAuthModel(phoneAuthModelState: PhoneAuthModelState.error);
    }
  }

  Future<PhoneAuthModel> verifyWithCredential({
    required AuthCredential credential,
  }) async {
    User? user = await _phoneAuthFirebaseProvider.authenticationWithCredential(
      credential: credential,
    );
    if (user != null) {
      return PhoneAuthModel(
        phoneAuthModelState: PhoneAuthModelState.verified,
        uid: user.uid,
      );
    } else {
      return PhoneAuthModel(phoneAuthModelState: PhoneAuthModelState.error);
    }
  }

  Stream<PhoneAuthModel> getAuthDetailStream() {
    return _phoneAuthFirebaseProvider.getAuthStates().map((user) {
      return _getAuthCredentialFromFirebaseUser(user: user);
    });
  }

  Future<User?> getUser() async {
    var user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<void> unAuthenticate() async {
    await _phoneAuthFirebaseProvider.logout();
  }

  PhoneAuthModel _getAuthCredentialFromFirebaseUser({required User? user}) {
    PhoneAuthModel authDetail;
    if (user != null) {
      authDetail = PhoneAuthModel(
        uid: user.uid,
        phoneAuthModelState: PhoneAuthModelState.verified,
      );
    } else {
      authDetail = PhoneAuthModel(
        phoneAuthModelState: PhoneAuthModelState.error,
      );
    }
    return authDetail;
  }
}
