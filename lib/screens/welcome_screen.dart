import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bolt_chat/components/styled_rounded_button.dart';
import 'package:bolt_chat/constants.dart';
import 'package:bolt_chat/screens/login_screen.dart';
import 'package:bolt_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation =
        ColorTween(begin: Colors.blueAccent[50], end: kScaffoldBackgroundColor)
            .animate(_controller);

    _controller.forward();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animation.value,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              opacity: 0.2,
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(children: <Widget>[
                Hero(
                  tag: "boltHero",
                  child: SizedBox(
                    height: 80,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                Text(
                  'Bolt ',
                  style: kBannerTextStyle.copyWith(color: kTextColor),
                ),
                DefaultTextStyle(
                  style: kBannerTextStyle,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Chat'),
                    ],
                    isRepeatingAnimation: true,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ]),
              const SizedBox(
                height: 88.0,
              ),
              StyledRoundedButton(
                onPressed: () {
                  //Go to login screen.
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                color: kLoginButtonColor,
                label: "Log In",
              ),
              StyledRoundedButton(
                  color: kRegisterButtonColor,
                  onPressed: () {
                    //Go to registration screen.
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  label: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}
