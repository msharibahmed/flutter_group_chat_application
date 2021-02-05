import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/loading_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  fontFamily: 'Lato',
                  primarySwatch: Colors.blue,
                  buttonTheme: ButtonTheme.of(context).copyWith(
                      buttonColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
              routes: {
                ChatScreen.routeName: (context) => ChatScreen(),
                AuthScreen.routeName: (context) => AuthScreen()
              },
              home: appSnapshot.connectionState != ConnectionState.done
                  ? LoadingScreen()
                  : StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LoadingScreen();
                        }
                        return snapshot.hasData ? ChatScreen() : AuthScreen();
                      }));
        });
  }
}
