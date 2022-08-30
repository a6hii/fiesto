part of 'phone_auth_bloc.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object?> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthStarted extends PhoneAuthState {}

class PhoneAuthSuccess extends PhoneAuthState {
  final PhoneAuthModel authenticationDetail;
  const PhoneAuthSuccess({
    required this.authenticationDetail,
  });
  @override
  List<Object> get props => [authenticationDetail];
}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthFailure extends PhoneAuthState {
  final String message;

  const PhoneAuthFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class PhoneAuthNumberVerficationFailure extends PhoneAuthState {
  final String message;
  const PhoneAuthNumberVerficationFailure(this.message);
  @override
  List<Object> get props => [message];
}

class PhoneAuthNumberVerificationSuccess extends PhoneAuthState {
  final String verificationId;
  const PhoneAuthNumberVerificationSuccess({
    required this.verificationId,
  });
  @override
  List<Object> get props => [verificationId];
}

class PhoneAuthCodeSentSuccess extends PhoneAuthState {
  final String verificationId;
  const PhoneAuthCodeSentSuccess({
    required this.verificationId,
  });
  @override
  List<Object> get props => [verificationId];
}

class PhoneAuthCodeVerficationFailure extends PhoneAuthState {
  final String message;
  final String verificationId;

  const PhoneAuthCodeVerficationFailure(this.message, this.verificationId);

  @override
  List<Object> get props => [message];
}

class PhoneAuthCodeVerificationSuccess extends PhoneAuthState {
  final String? uid;

  const PhoneAuthCodeVerificationSuccess({
    required this.uid,
  });

  @override
  List<Object?> get props => [uid];
}

// class PhoneAuthCodeAutoRetrevalTimeoutComplete extends PhoneAuthState {
//   final String verificationId;

//   const PhoneAuthCodeAutoRetrevalTimeoutComplete(this.verificationId);
//   @override
//   List<Object> get props => [verificationId];
// }
