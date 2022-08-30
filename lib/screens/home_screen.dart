import 'package:fiesto/blocs/phone_auth_bloc/phone_auth_bloc.dart';
import 'package:fiesto/screens/home_view.dart';
import 'package:fiesto/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthFailure) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PhoneAuthInitial) {
          BlocProvider.of<PhoneAuthBloc>(context).add(PhoneAuthCheckUser());
          return const CircularProgressIndicator();
        } else if (state is PhoneAuthLoading) {
          return const CircularProgressIndicator();
        } else if (state is PhoneAuthSuccess) {
          return const HomeScreen();
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
