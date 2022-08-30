import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiesto/screens/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectCityScreen extends StatelessWidget {
  const SelectCityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select City',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[400],
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () async {
                    final uid = FirebaseAuth.instance.currentUser!.uid;
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .update({
                      'city': 'Patna',
                    });
                    Future.delayed(Duration.zero, () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.routeName, (route) => false);
                    });
                  }, //goes to homepage where we load the venues only in that the city
                  child: const Text(
                    'Patna',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[400],
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () async {
                    final uid = FirebaseAuth.instance.currentUser!.uid;
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .update({
                      'city': 'Delhi',
                    });
                    Future.delayed(Duration.zero, () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.routeName, (route) => false);
                    });
                  },
                  child: const Text(
                    'Delhi',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
