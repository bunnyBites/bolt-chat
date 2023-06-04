import 'package:bolt_chat/screens/chat_screen.dart';
import 'package:bolt_chat/screens/login_screen.dart';
import 'package:bolt_chat/screens/registration_screen.dart';
import 'package:bolt_chat/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BoltChat());
}


class BoltChat extends StatelessWidget {
  const BoltChat({super.key});

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
