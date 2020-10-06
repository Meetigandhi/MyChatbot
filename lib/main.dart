import 'package:flutter/material.dart';
import 'package:mychatbot/screens/dashboard.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/start_screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {

    return MaterialApp(
      title: 'My ChatBot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:GetStartScreen(),
      routes: {
        LoginScreen.routeName:(context)=>LoginScreen(),
        SignupScreen.routeName:(context)=>SignupScreen(),
        Dashboard.routeName:(context)=>Dashboard(),
      },
    );
  }
}