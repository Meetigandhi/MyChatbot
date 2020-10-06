import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mychatbot/screens/dashboard.dart';
import 'package:toast/toast.dart';
class LoginScreen extends StatefulWidget {
  static const routeName="/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email="",_password="";
  bool _emailvalidate=true,_passvalidate=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
//        color: Theme.of(context).primaryColor,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/login.png',height: 130,),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email Id',
                      filled: true,
                      errorText: !_emailvalidate?'Please Enter Email':null,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      )
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email=value.trim();
                    });

                  },
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      errorText: !_passvalidate?'Please Enter Password':null,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      )
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password=value.trim();
                    });

                  },
                ),
              ),
              SizedBox(height: 20,),
              FlatButton(
                child: Text('Login',style: TextStyle(fontSize: 18),),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  if(_email.isEmpty)
                  {
                    setState(() {
                      _emailvalidate=false;
                    });
                  }
                  else{
                    setState(() {
                      _emailvalidate=true;
                    });
                  }
                  if(_password.isEmpty)
                  {
                    setState(() {
                      _passvalidate=false;
                    });
                  }
                  else{
                    setState(() {
                      _passvalidate=true;
                    });
                  }
                  if(_emailvalidate && _passvalidate)
                    {
                          signin();
                    }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signin() async
  {

      try{

        FirebaseUser user=(await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;

        Navigator.of(context).pushNamed(Dashboard.routeName);

      }
      catch(ex)
      {
        Toast.show(ex.message, context,duration: Toast.LENGTH_LONG);
        //print(ex.message);
      }

  }
}
