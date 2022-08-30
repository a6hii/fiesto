import 'package:fiesto/blocs/phone_auth_bloc/phone_auth_bloc.dart';
import 'package:fiesto/constants.dart';
import 'package:fiesto/screens/home_screen.dart';

import 'package:fiesto/screens/otp_verification_screen.dart';
import 'package:fiesto/widgets/link_and_text.dart';
import 'package:fiesto/widgets/login/fade_slide_transition.dart';

import 'package:fiesto/widgets/login/phone_number_input.dart';

import 'package:fiesto/widgets/white_radial_gradient.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';

  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _headerTextAnimation;
  late final Animation<double> _formElementAnimation;
  late final Animation<double> _whiteTopClipperAnimation;
  TextEditingController controller = TextEditingController();
  bool isCheckBoxSelected = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );

    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ));
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors
            .transparent, //use fade animation, extract widgets and reorder, make widgets for otp like in mynotes
        body: SafeArea(
          //in bloc listner navigate to verify otp screen on phone auth number verific.. succsess=
          child: Builder(builder: (context) {
            return BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
              listener: (context, state) {
                if (state is PhoneAuthSuccess) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                } else if (state is PhoneAuthCodeSentSuccess) {
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => OtpVerificationScreen(
                        bottomRight: 0.0,
                        topRight: 30.0,
                      ),
                    ));
                  });
                } else if (state is PhoneAuthNumberVerficationFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    elevation: 2,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(24),
                    backgroundColor: Colors.blue,
                  ));
                } else if (state is PhoneAuthNumberVerificationSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('OTP sent'),
                    elevation: 2,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(24),
                    backgroundColor: Colors.blue,
                  ));
                } else if (state is PhoneAuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    elevation: 2,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(24),
                    backgroundColor: Colors.blue,
                  ));
                }
              },
              buildWhen: (current, next) {
                if (next is PhoneAuthSuccess) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state is PhoneAuthInitial ||
                    state is PhoneAuthNumberVerficationFailure ||
                    state is PhoneAuthFailure) {
                  return Stack(children: [
                    const RadialWhiteCenterGradient(),
                    FadeSlideTransition(
                      additionalOffset: 0,
                      animation: _formElementAnimation,
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: SizedBox(
                                height: 180,
                                child: Image.asset(
                                  'assets/images/flogo.png',
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                ),
                              ),
                            ),
                            const Text(
                              'Fiesto',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'You celebrate, we plan.',
                              style: TextStyle(
                                color: Color(0xFF999A9A),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 400,
                            ),
                            // const Text(
                            //   'Having trouble in logging in? Contact support.',
                            //   style: TextStyle(
                            //     color: Color(0xFF999A9A),
                            //     fontSize: 12,
                            //   ),
                            // ),
                            const LinkAndText(
                              normalText: "Having trouble in logging in? ",
                              linkText: "Please contact support.",
                              mainAxisAlignment: MainAxisAlignment.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    FadeSlideTransition(
                      additionalOffset: 30,
                      animation: _formElementAnimation,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 6),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, bottom: 6),
                              child: Text(
                                "Please verify your phone number.",
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 22,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)
                                          .withOpacity(0.7),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 40, bottom: 10),
                              child: Text(
                                "OTP will be sent to this number.",
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 16,
                                  color: Colors.white38,
                                ),
                              ),
                            ),
                            Stack(
                              //alignment: Alignment.bottomRight,
                              children: <Widget>[
                                InputWidget(
                                  30.0,
                                  0.0,
                                  controller: controller,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 70, left: 30),
                                        child: Checkbox(
                                          shape: const CircleBorder(),
                                          value: isCheckBoxSelected,
                                          checkColor: Colors.blue,
                                          onChanged: (value) {
                                            setState(() {
                                              isCheckBoxSelected == false
                                                  ? isCheckBoxSelected = true
                                                  : isCheckBoxSelected = false;
                                            });
                                          },
                                          activeColor: Colors.black,
                                          fillColor: MaterialStateProperty.all(
                                            isCheckBoxSelected == false
                                                ? const Color(0xFF999A9A)
                                                : const Color.fromARGB(
                                                    255,
                                                    48,
                                                    48,
                                                    48), //correct the checkbox color
                                          ),
                                          splashRadius: 15,
                                        )),
                                    const Padding(
                                        padding:
                                            EdgeInsets.only(top: 70, left: 0),
                                        child: LinkAndText(
                                          normalText: "You agree to our  ",
                                          linkText: "Terms and Conditions",
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                        )),
                                  ],
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 50),
                            ),
                          ]),
                    ),
                    Positioned(
                        top: 420,
                        right: 30,
                        child: InkWell(
                          overlayColor: MaterialStateProperty.all(Colors
                              .transparent), //removes background splash color
                          onTap: () {
                            BlocProvider.of<PhoneAuthBloc>(context).add(
                                PhoneAuthNumberVerified(
                                    phoneNumber: '+91${controller.text}'));
                          },
                          child: FadeSlideTransition(
                            additionalOffset: 0,
                            animation: _formElementAnimation,
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
                        ))
                  ]);
                } else if (state is PhoneAuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            );
          }),
        ));
  }
}


// void _showSnackBarWithText(
//     {required BuildContext context, required String textValue}) {
//   ScaffoldMessenger.of(context)
//       .showSnackBar(SnackBar(content: Text(textValue)));
// }
