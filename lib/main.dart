import 'package:chat_app/auth_screen.dart';
import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/colors.dart';
import 'package:chat_app/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xffFF6A88),
      brightness: Brightness.light,
      primary: bbPrimary,
      secondary: bbSecondary,
      background: bbWhite,
      onBackground: bbBlack,
    );

    final theme = ThemeData.from(
      colorScheme: colorScheme,
    );
    return MaterialApp(
      title: 'Flutter Chat',
      theme: theme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return const AuthScreen();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
