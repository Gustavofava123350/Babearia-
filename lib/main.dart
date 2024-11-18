import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ellys/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HOMEPage(),
    );
  }
}
