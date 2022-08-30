import 'package:fiesto/blocs/phone_auth_bloc/phone_auth_bloc.dart';
import 'package:fiesto/blocs/splash_bloc/splashscreen_bloc.dart';
import 'package:fiesto/config/theme.dart';
import 'package:fiesto/firebase_options.dart';

import 'package:fiesto/providers/phone_auth_provider.dart';
import 'package:fiesto/repo/phone_auth_repo.dart';
import 'package:fiesto/screens/home_view.dart';
import 'package:fiesto/screens/new_user_signup_screen.dart';
import 'package:fiesto/screens/onboarding/onboarding_screen_one.dart';
import 'package:fiesto/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/login_screen.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhoneAuthBloc>(
            create: (context) => PhoneAuthBloc(
                  phoneAuthRepository: PhoneAuthRepository(
                    phoneAuthFirebaseProvider: PhoneAuthFirebaseProvider(
                      firebaseAuth: FirebaseAuth.instance,
                    ),
                  ),
                )),
        BlocProvider<SplashScreenBloc>(
          create: (context) => SplashScreenBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Fiesto',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.system,
        home: Builder(
          builder: (BuildContext context) {
            //final screenHeight = MediaQuery.of(context).size.height;

            return const SplashScreen();
          },
        ),
        //home: const OnBoardingScreen(),

        //initialRoute: SplashScreen.id,
        routes: {
          //HomeScreen.id: (context) => const HomeScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          OnBoardingScreen.id: (context) => OnBoardingScreen(
                screenHeight: MediaQuery.of(context).size.height,
              ),
          LoginScreen.id: (context) => const LoginScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          NewUserSignupScreen.routeName: (context) => NewUserSignupScreen(),
        },
      ),
    );
  }
}
