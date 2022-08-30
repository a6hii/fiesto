import 'package:fiesto/blocs/phone_auth_bloc/phone_auth_bloc.dart';
import 'package:fiesto/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/generic_dialog.dart';

enum MenuAction { logout }

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Logout',
    content: 'Do you really want to logout?',
    optionsBuilder: () => {
      'No': false,
      'Yes, Logout': true,
    },
  ).then(
    (value) => value ?? false,
  );
}

class HomeScreen extends StatelessWidget {
  //final String city;
  const HomeScreen({
    super.key,
    //required this.city,
  });
  static const String routeName = '/HomeScreen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthBloc, PhoneAuthState>(
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
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome'),
            //automaticallyImplyLeading: false,
            actions: [
              PopupMenuButton<MenuAction>(
                onSelected: (value) async {
                  switch (value) {
                    case MenuAction.logout:
                      final shouldLogout = await showLogOutDialog(context);
                      if (shouldLogout) {
                        Future.delayed(Duration.zero, () {
                          context.read<PhoneAuthBloc>().add(
                                PhoneAuthLoggedOut(),
                              );
                        });
                      }
                  }
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<MenuAction>(
                      value: MenuAction.logout,
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ];
                },
              )
            ],
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // ElevatedButton(
              //   onPressed: () {
              //     context.read<PhoneAuthBloc>().add(
              //           PhoneAuthLoggedOut(),
              //         );
              //   },
              //   child: const Text(
              //     'Logout',
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
              Text(
                'Home',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ))),
    );
  }
}
