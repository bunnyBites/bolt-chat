import 'package:bolt_chat/components/styled_rounded_button.dart';
import 'package:bolt_chat/constants.dart';
import 'package:bolt_chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const id = "registration_screen";

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: "flashHero",
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              style: const TextStyle(color: Colors.black),
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            const SizedBox(
              height: 24.0,
            ),
            StyledRoundedButton(
              color: Colors.blueAccent,
              onPressed: () {
                _auth
                    .createUserWithEmailAndPassword(
                        email: email, password: password)
                    .then((user) =>
                        {Navigator.pushNamed(context, ChatScreenState.id)})
                    .catchError((err) => print(err));
              },
              label: "Register",
            )
          ],
        ),
      ),
    );
  }
}
