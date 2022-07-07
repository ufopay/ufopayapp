import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ufopayapp/about/about.dart';
import 'package:ufopayapp/login/login.dart';
import 'package:ufopayapp/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading");
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('error'),
            );
          } else if (snapshot.hasData) {
            return const AboutScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
