import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/login.dart';
import 'package:myapp/screens/mood.dart';
import 'package:myapp/screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    routes: {
      '/home': (BuildContext context) => HomePage(),
      '/mood': (BuildContext context) => Mood(),
      '/login': (BuildContext context) => Login(),
      '/register': (BuildContext context) => Register()
    },
    initialRoute: '/home',
  ));
}
