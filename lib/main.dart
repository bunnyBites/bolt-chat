import 'package:bolt_chat/screens/chat_screen.dart';
import 'package:bolt_chat/screens/login_screen.dart';
import 'package:bolt_chat/screens/registration_screen.dart';
import 'package:bolt_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.black54),
        ),
      ),
      // home: const WelcomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        ChatScreenState.id: (context) => const ChatScreenState(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen()
      },
    );
  }
}
