import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:ufopayapp/services/auth.dart';
import 'package:ufopayapp/shared/bottom_nav.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登入"),
      ),
      body: LogginButtons(),
    );
  }
}

class LogginButtons extends StatelessWidget {
  const LogginButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            LoginButton(
              text: '以Google帳戶登入',
              icon: FontAwesomeIcons.google,
              color: Colors.blue,
              loginMethod: AuthService().googleLogin,
            ),
            LoginButton(
              icon: FontAwesomeIcons.userNinja,
              text: '以訪客登入',
              loginMethod: AuthService().anonLogin,
              color: Colors.deepPurple,
            ),
            FutureBuilder<Object>(
              future: SignInWithApple.isAvailable(),
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return LoginButton(
                    icon: FontAwesomeIcons.apple,
                    text: '以Apple帳戶登入',
                    loginMethod: AuthService().signInWithApple,
                    color: Colors.black,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ]),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: () => loginMethod(),
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
