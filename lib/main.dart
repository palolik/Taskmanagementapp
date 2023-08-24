import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/screens/signin_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBRffTpq-OjnRUduFN-OtmnpnqvHkkv-f4",
          authDomain: "collegeconnect-262df.firebaseapp.com",
          projectId: "collegeconnect-262df",
          storageBucket: "collegeconnect-262df.appspot.com",
          messagingSenderId: "463624953126",
          appId: "1:463624953126:web:66c6dc0290298e4e79f5e7"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
    );
  }
}

