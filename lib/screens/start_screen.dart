
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class GetStartScreen extends StatefulWidget
{
  @override
  _GetStartScreenState createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {


  Widget build(BuildContext context)
  {

    return Scaffold(

     body:
     Container(
       color: Colors.white,
       child: Padding(
         padding: const EdgeInsets.all(20),
          child: Column(
             children: <Widget>[
               Expanded(
                 child: Stack(
                   alignment: AlignmentDirectional.bottomCenter,
                   children: <Widget>[
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[

                         Container(
                           width: 300,
                           height: 100,
                           decoration: BoxDecoration(
                             shape: BoxShape.rectangle,
                             image: DecorationImage(image: AssetImage("assets/clg.png"),
                               fit: BoxFit.fill,
                             ),
                           ),
                         ),
                         SizedBox(height: 40,),
                         Text('My ChatBot',
                           style: TextStyle(
                             fontSize: 35,
                             fontWeight: FontWeight.bold,
                             color: Theme.of(context).primaryColor,
                           ),
                         ),
                         SizedBox(height: 20,),
                         Text('This is chatbot application for giving information about Charusat University',
                           textAlign: TextAlign.center,
                           style: TextStyle(fontSize: 20, color: Colors.blue),
                         ),
                         SizedBox(height: 20,),
                       ],
                     ),

                   ],

                 ),
               ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                   FlatButton(
                     child: Text('Getting Started',style: TextStyle(fontSize: 18),),
                     padding: const EdgeInsets.all(15),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(5),
                     ),
                     color: Theme.of(context).primaryColor,
                     textColor: Colors.white,
                     onPressed: () {
                       Navigator.of(context).pushNamed(SignupScreen.routeName);
                     },
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text('Have an Account?',style: TextStyle(fontSize: 18),),
                       FlatButton(
                         child: Text('Login',style: TextStyle(fontSize: 18),),
                        onPressed: () {
                          Navigator.of(context).pushNamed(LoginScreen.routeName);
                        },
                       ),
                     ],)
                 ],)
             ],
           )
       ),
     )

    );
  }
}