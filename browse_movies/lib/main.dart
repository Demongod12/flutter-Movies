import 'package:browse_movies/screens/splash_screen.dart';
import 'package:browse_movies/util/favourite_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:browse_movies/screens/signup_screen.dart';
import 'package:browse_movies/screens/login_screen.dart';
import 'package:browse_movies/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SplashScreen();
          }
        },
      ),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const SignInScreen(),
        '/home': (context) => const HomeScreen(),
        '/favourite': (context) => const FavouriteScreen(),
      },
    );
  }
}
