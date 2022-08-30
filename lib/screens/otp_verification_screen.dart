import 'package:fiesto/blocs/phone_auth_bloc/phone_auth_bloc.dart';
import 'package:fiesto/constants.dart';

import 'package:fiesto/screens/home_view.dart';
import 'package:fiesto/screens/new_user_signup_screen.dart';
import 'package:fiesto/widgets/link_and_text.dart';
import 'package:fiesto/widgets/login/otp_input_field.dart';
import 'package:fiesto/widgets/white_radial_gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpVerificationScreen extends StatelessWidget {
  final double topRight;
  final double bottomRight;

  OtpVerificationScreen({
    super.key,
    required this.topRight,
    required this.bottomRight,
  });
  final int start = 30;
  final bool wait = false;
  final String buttonName = "Verify";
  final TextEditingController _codeController = TextEditingController();

  final String smsCode = "";

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          splashRadius: 0.2,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: kBlack,
      body: BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
        listener: (context, state) {
          if (state is PhoneAuthCodeVerificationSuccess ||
              state is PhoneAuthSuccess) {
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //   builder: (_) => FirebaseAuth.instance.currentUser!.email == null
            //       ? NewUserSignupScreen()
            //       : const HomeScreen(),
            // ));
            if (FirebaseAuth.instance.currentUser!.email == null) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  NewUserSignupScreen.routeName, (route) => false);
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName, (route) => false);
            }
          } else if (state is PhoneAuthCodeVerficationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              elevation: 2,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(24),
              backgroundColor: Colors.blue,
            ));
          }
        },
        builder: (context, state) {
          if (state is PhoneAuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              const RadialWhiteCenterGradient(),
              Container(
                alignment: Alignment.topCenter,
                //color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 90, right: 10, bottom: 20),
                  child: SvgPicture.asset(
                    'assets/msgsent.svg',
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitHeight,
                    height: 250,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 7),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, bottom: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("OTP Verification",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)
                                          .withOpacity(0.7),
                                  fontSize: 24)),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Enter 6 digits OTP sent ", //to ${phoneNumber!}
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  OtpInput(
                      bottomRight: bottomRight,
                      topRight: topRight,
                      codeController: _codeController),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 0),
                    child: LinkAndText(
                      normalText: "Didn't receice the OTP?",
                      linkText: "Resend OTP",
                      mainAxisAlignment: MainAxisAlignment.start,
                      onpressed: () {},
                    ),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     const Text(
                    //       "Didn't receive the OTP?",
                    //       style: TextStyle(
                    //         color: Colors.white38,
                    //         fontSize: 14,
                    //       ),
                    //     ),
                    //     TextButton(
                    //       child: Text(
                    //         "RESEND OTP",
                    //         style: TextStyle(
                    //           color: Colors.blue[200],
                    //           fontSize: 14,
                    //         ),
                    //       ),
                    //       // onPressed: () async {
                    //       //   setState(() {
                    //       //     this._status = Status.Waiting;
                    //       //   });
                    //       //   _verifyPhoneNumber();
                    //       // },
                    //       onPressed: () {},
                    //     ),
                    //   ],
                    // ),
                  )
                ],
              ),
              Positioned(
                top: 455,
                right: 30,
                child: InkWell(
                  overlayColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ),
                  onTap: () {
                    if (state is PhoneAuthNumberVerificationSuccess) {
                      context.read<PhoneAuthBloc>().add(PhoneAuthCodeVerified(
                          smsCode: _codeController.text,
                          verificationId: state.verificationId));
                    } else if (state is PhoneAuthCodeVerficationFailure) {
                      context.read<PhoneAuthBloc>().add(PhoneAuthCodeVerified(
                          smsCode: _codeController.text,
                          verificationId: state.verificationId));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      gradient: LinearGradient(
                          colors: signInGradients,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                    child: const Icon(
                      Icons.arrow_right_rounded,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // void _verifySMS(BuildContext context, String verificationCode) {
  //   BlocProvider.of<PhoneAuthBloc>(context).add(PhoneAuthCodeVerified(
  //       verificationId: verificationCode, smsCode: _codeController.text));
  // }

  // void _showSnackBarWithText(
  //     {required BuildContext context, required String textValue}) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(textValue)));
  // }
}
