import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/loading_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
            primarySwatch: Colors.blue,
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
        routes: {
          ChatScreen.routeName: (context) => ChatScreen(),
          AuthScreen.routeName: (context) => AuthScreen()
        },
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingScreen();
              }
              return snapshot.hasData ? ChatScreen() : AuthScreen();
            }));
  }
}
