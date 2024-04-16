// app.dart

import 'package:flutter/material.dart';
import 'package:proyecto2flutter/src/screens/login.screens.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
