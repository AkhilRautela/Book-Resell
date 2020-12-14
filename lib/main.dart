import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'home.dart';
import 'login.dart';
import 'signup.dart';
import 'package:bookresell/routes.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      initialRoute: '/',
      onGenerateRoute: Routegenerator.generateroute,
      debugShowCheckedModeBanner: false,
      home:Home()
    )
  );
}
