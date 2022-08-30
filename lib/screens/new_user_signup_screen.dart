import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiesto/screens/select_city_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewUserSignupScreen extends StatelessWidget {
  NewUserSignupScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  static const String routeName = '/NewUserSignupScreen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => NewUserSignupScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 120,
            ),
            const Text(
              'Sign up',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Material(
                elevation: 10,
                color: const Color.fromARGB(255, 20, 20, 20),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                      fillColor: Colors.black54,
                      border: InputBorder.none,
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(
                        color: Colors.white38,
                        fontSize: 18,
                      ),
                      contentPadding: EdgeInsets.only(left: 10)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Material(
                elevation: 10,
                color: const Color.fromARGB(255, 20, 20, 20),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 18,
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[400],
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.currentUser!
                      .updateDisplayName(_nameController.text);
                  await FirebaseAuth.instance.currentUser!
                      .updateEmail(_emailController.text);
                  final uid = FirebaseAuth.instance.currentUser!.uid;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .update({
                    'name': _nameController.text,
                    'email': _emailController.text,
                  });
                  Future.delayed(Duration.zero, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Saved.'),
                        elevation: 2,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(24),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  });
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const SelectCityScreen(),
                    ));
                  });
                },
                child: const Text(
                  'Continue to choose location',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
