import 'package:fiesto/blocs/splash_bloc/splashscreen_bloc.dart';
import 'package:fiesto/screens/home_screen.dart';

import 'package:fiesto/screens/onboarding/onboarding_screen_one.dart';
import 'package:fiesto/shared_preferences_manager.dart';
import 'package:fiesto/widgets/splashscreen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);
  static const String id = 'splash-screen';

  // final splashDelay = 2;

  // @override
  // void initState() {
  //   super.initState();

  //   _loadWidget();
  // }

  // _loadWidget() async {
  //   var _duration = Duration(seconds: splashDelay);
  //   return Timer(_duration, checkFirstSeen);
  // }

  // Future checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _seen = (prefs.getBool('seen') ?? false);

  //   if (_seen) {
  //     return HomeScreen.id;
  //   } else {
  //     // Set the flag to true at the end of onboarding screen if everything is successfull and so I am commenting it out
  //     // await prefs.setBool('seen', true);
  //     return OnBoardingScreen.id;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }

  BlocProvider<SplashScreenBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashScreenBloc(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Center(
          // Here I have used BlocBuilder, but instead you can also use BlocListner as well.
          child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
            builder: (context, state) {
              //double screenHeight = MediaQuery.of(context).size.height;
              if ((state is SplashScreenInitial) ||
                  (state is SplashScreenLoading)) {
                return const SplashScreenWidget();
              } else if (state is SplashScreenLoaded) {
                //return HomeScreen();
                return FutureBuilder(
                    future: SharedPreferencesManager().isFreshInstalled(),
                    builder: (context, isFreshInstalledSnapshot) {
                      double screeHeight = MediaQuery.of(context).size.height;
                      if (isFreshInstalledSnapshot.hasData) {
                        if (isFreshInstalledSnapshot.data == true) {
//You can return for example your onboarding widget/page
                          return OnBoardingScreen(
                            screenHeight: screeHeight,
                          );
                        } else {
//You can return your HomePage() or whatever widget/page
                          // return BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
                          //   builder: (context, state) {
                          //     if (state is PhoneAuthSuccess) {
                          //       return const HomeScreen();
                          //     } else if (state is PhoneAuthFailure) {
                          //       return const LoginScreen();
                          //     } else {
                          //       return const Scaffold();
                          //     }
                          //   },
                          // );
                          return const HomePage(); //login
                        }
                      } else {
//For good user Experiance you can show Your App Logo/loading Screen
                        return const Center(child: CircularProgressIndicator());
                      }
                    });
              } else {
                return const Text(
                    'Error/Check your internet connection\nTry to restart the app');
              }
            },
          ),
        ),
      ),
    );
  }
}
