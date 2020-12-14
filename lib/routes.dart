import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'signup.dart';
import 'chatperperson.dart';
class Routegenerator{
  static Route<dynamic> generateroute(RouteSettings settings){
    final args=settings.arguments;
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=>Home());
      case '/login':
        return MaterialPageRoute(builder: (_)=>Login());
      case '/signup':
        return MaterialPageRoute(builder: (_)=>Signup());
      case '/chat':
        return MaterialPageRoute(builder: (_)=>Chatperperson());
    }
  }
}