import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychatbot/screens/login_screen.dart';
import 'package:toast/toast.dart';
class SignupScreen extends StatefulWidget {
  static const routeName="/signup";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _email="",_password="",_cpassword="";

  bool _emailvalidate=true,_passvalidate=true,_cpassvalidate=true,_passvalidate2=true,_cpassvalidate2=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
              Image.asset('assets/signup.png',height: 130,),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                child: Divider(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                child: TextField(

                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      errorText: !_emailvalidate?'Please Enter Email':null,
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
                      _email=value.trim();
                    });

                  },
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      errorText: !_passvalidate?'Please Enter Password':!_passvalidate2?'Password Contains atleast 6 characters':null,
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
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Confirm Password',
                      errorText: !_cpassvalidate?'Please Enter Confirm Password':!_cpassvalidate2?'Confirm Password is not match':null,
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
                      _cpassword=value.trim();
                    });

                  },
                ),
              ),

              SizedBox(height: 20,),
              FlatButton(
                child: Text('Register',style: TextStyle(fontSize: 18),),
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
                    if(_password.length<6)
                    {
                      setState(() {
                        _passvalidate2=false;
                      });
                    }
                    else{
                      setState(() {
                        _passvalidate2=true;
                      });
                    }
                    if(_cpassword.isEmpty)
                    {
                      setState(() {
                        _cpassvalidate=false;
                      });
                    }
                    else{
                      setState(() {
                        _cpassvalidate=true;
                      });
                    }
                    if(_cpassword.compareTo(_password)!=0)
                    {
                      setState(() {
                        _cpassvalidate2=false;
                      });
                    }
                    else{
                      setState(() {
                        _cpassvalidate2=true;
                      });
                    }
                    if(_emailvalidate&&_passvalidate&&_passvalidate2&&_cpassvalidate&&_cpassvalidate2)
                      {
                        signup();
                      }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future signup() async
  {

    try{
      AuthResult rs=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      FirebaseUser user=rs.user;
      if(user==null)
      {
        Toast.show("Registration is Not Completed", context,duration: Toast.LENGTH_LONG);
      }
      else
      {
        Toast.show("Registration is Completed", context,duration: Toast.LENGTH_LONG);
        Navigator.of(context).pushNamed(LoginScreen.routeName);

      }

    }
    catch(ex)
    {
      print(ex.message);

    }


  }
}

