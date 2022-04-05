// ignore_for_file: always_declare_return_types, type_annotate_public_apis

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Client client = http.Client();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  Future<void> registertoDjango() async {
    const url = 'https://livine.pythonanywhere.com/api/register/';
    await client.post(Uri.parse(url), body: {
      'username': _username.text,
      'email': _email.text,
      'password': _confirmPassword.text,
    },);
    if (mounted) {
      Navigator.pushNamed(context, '/login');
    }
  }
  bool isLoading = false;
  validateForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });
      registertoDjango();
    } else{
      setState(() {
        isLoading = false;
      });
    }
  }

  bool _obscureText = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/images/login/back_arrow.svg',
            width: 25.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: Padding(
          padding: EdgeInsets.all(23),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          maxLength: 20,
                          validator: (u) {
                            if (u!.isEmpty) {
                              return "Please enter your username";
                            } else if (u.length >= 20) {
                              return "Username shouldn't be more than 20 characters";
                            }
                            return null;
                          },
                          controller: _username,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(),),
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  fontSize: 15, color: Colors.black,),),
                        ),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                        controller: _email,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(),),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontSize: 15, color: Colors.black,),),
                      ),
                      TextFormField(
                        validator: (passwordValue) {
                          if (passwordValue!.length < 6 && passwordValue.isNotEmpty) {
                            return "Password needs to be atleast 6 characters ";
                          } else if (passwordValue.isEmpty) {
                            return "Please enter your password ";
                          }
                          return null;
                        },
                        controller: _password,
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(),),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black),),
                      ),
                      TextFormField(
                        validator: (confirmPassword) {
                          if(_confirmPassword.value != _password.value ){
                            return "Confirm password doesn't match with your password";
                          }
                          return null;
                        },
                        controller: _confirmPassword,
                        obscureText: _obscureText,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                                                      suffixIcon: IconButton(
                              icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _obscureText
                                      ? Colors.grey
                                      : Colors.blueAccent[400],),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(),),
                            labelText: 'Confirm Password',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black),),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: MaterialButton(
                  onPressed: validateForm,
                  color: Colors.blueAccent[400],
                  elevation: 0,
                  minWidth: 350,
                  height: 60,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),),
                  child: isLoading ?  CircularProgressIndicator(
                    color: Colors.white,
                  ) : Text(
                    'SIGN UP',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/login'),
                        child: Text(
                          'Sign In'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.blueAccent[400],
                              fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Center(child: Text("By creating an account , you already agree on ")),
              SizedBox(height: 10.0,),
              Center(
                child: GestureDetector(
                  onTap: ()=> Navigator.pushNamed(context, '/terms'),
                  child: Text("Terms and Conditions",style: TextStyle(color: Colors.blue),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
