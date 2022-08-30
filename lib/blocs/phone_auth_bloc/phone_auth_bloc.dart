import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fiesto/models/phone_auth.dart';
import 'package:fiesto/repo/phone_auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final PhoneAuthRepository _phoneAuthRepository;
  StreamSubscription<PhoneAuthModel>? authStreamSub;

  PhoneAuthBloc({
    required PhoneAuthRepository phoneAuthRepository,
  })  : _phoneAuthRepository = phoneAuthRepository,
        super(PhoneAuthInitial()) {
    on<PhoneAuthCheckUser>((event, emit) {
      try {
        emit(PhoneAuthLoading());
        authStreamSub =
            _phoneAuthRepository.getAuthDetailStream().listen((authDetail) {
          add(PhoneAuthStateChanged(authenticationDetail: authDetail));
        });
      } catch (e) {
        print(
          'Error occured while fetching authentication detail : ${e.toString()}',
        );
        emit(
          const PhoneAuthFailure(
            message: 'Error occrued while fetching auth detail',
          ),
        );
      }
    });
    on<PhoneAuthStateChanged>((event, emit) {
      if (event.authenticationDetail.phoneAuthModelState ==
          PhoneAuthModelState.verified) {
        emit(
            PhoneAuthSuccess(authenticationDetail: event.authenticationDetail));
      } else {
        emit(const PhoneAuthFailure(message: 'User has logged out'));
      }
    });
    on<PhoneAuthNumberVerified>(_phoneAuthNumberVerifiedToState);
    on<PhoneAuthCodeVerified>(_phoneAuthCodeVerifiedToState);
    // on<PhoneAuthCodeAutoRetrevalTimeout>((event, emit) {
    //   emit(
    //     PhoneAuthCodeAutoRetrevalTimeoutComplete(
    //       event.verificationId,
    //     ),
    //   );
    // });
    on<PhoneAuthCodeSent>((event, emit) {
      emit(
        PhoneAuthCodeSentSuccess(
          verificationId: event.verificationId,
        ),
      );
      emit(PhoneAuthNumberVerificationSuccess(
          verificationId: event.verificationId));
    });
    on<PhoneAuthVerificationFailed>((event, emit) {
      emit(
        PhoneAuthNumberVerficationFailure(
          event.message,
        ),
      );
    });
    on<PhoneAuthVerificationCompleted>((event, emit) async {
      emit(
        PhoneAuthCodeVerificationSuccess(
          uid: event.uid,
        ),
      );
    });
    on<PhoneAuthLoggedOut>((event, emit) async {
      try {
        emit(PhoneAuthLoading());
        await _phoneAuthRepository.unAuthenticate();
      } catch (error) {
        print('Error occured while logging out. : ${error.toString()}');
        emit(const PhoneAuthFailure(
            message: 'Unable to logout. Please try again.'));
      }
    });
  }

  void _phoneAuthNumberVerifiedToState(
      PhoneAuthNumberVerified event, Emitter<PhoneAuthState> emit) async {
    try {
      emit(PhoneAuthLoading());
      await _phoneAuthRepository.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        onCodeAutoRetrievalTimeOut: _onCodeAutoRetrievalTimeout,
        onCodeSent: _onCodeSent,
        onVerificaitonFailed: _onVerificationFailed,
        onVerificationCompleted: _onVerificationCompleted,
      );
    } on Exception catch (e) {
      print('Exception occured while verifying phone number ${e.toString()}');
      emit(PhoneAuthNumberVerficationFailure(e.toString()));
    }
  }

  void _phoneAuthCodeVerifiedToState(
      PhoneAuthCodeVerified event, Emitter<PhoneAuthState> emit) async {
    try {
      emit(PhoneAuthLoading());
      PhoneAuthModel phoneAuthModel = await _phoneAuthRepository.verifySMSCode(
          smsCode: event.smsCode, verificationId: event.verificationId);
      emit(PhoneAuthCodeVerificationSuccess(uid: phoneAuthModel.uid));
    } on Exception catch (e) {
      print('Excpetion occured while verifying OTP code ${e.toString()}');
      emit(PhoneAuthCodeVerficationFailure(e.toString(), event.verificationId));
    }
  }

  void _onVerificationCompleted(PhoneAuthCredential credential) async {
    final PhoneAuthModel phoneAuthModel =
        await _phoneAuthRepository.verifyWithCredential(credential: credential);

    if (phoneAuthModel.phoneAuthModelState == PhoneAuthModelState.verified) {
      add(PhoneAuthVerificationCompleted(phoneAuthModel.uid));
    }
  }

  void _onVerificationFailed(FirebaseException exception) {
    print(
        'Exception has occured while verifying phone number: ${exception.toString()}');
    add(PhoneAuthVerificationFailed(exception.toString()));
  }

  void _onCodeSent(String verificationId, int? token) {
    print(
        'Print code is successfully sent with verification id $verificationId and token $token');

    add(PhoneAuthCodeSent(
      token: token,
      verificationId: verificationId,
    ));
  }

  void _onCodeAutoRetrievalTimeout(String verificationId) {
    print('Auto retrieval has timed out for verification ID $verificationId');
    //add(PhoneAuthNumberVerified(phoneNumber: ));
  }
}
