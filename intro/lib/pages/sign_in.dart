import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intro/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function changeView;
  SignIn({this.changeView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: 300,
                child: Image(
                  image: AssetImage("images/Login.png"),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'E-mail',
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter proper Email' : null,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                          ),
                          validator: (value) => value.length < 6
                              ? 'Password length must be of 6 characters'
                              : null,
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      CheckboxListTile(
                        title: Text('ADMIN'),
                        value: checkValue,
                        onChanged: (value) {
                          setState(() {
                            checkValue = value;
                          });
                        },
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () async {
                          if ((email == 'admin@mail.com') &
                              (checkValue == true)) {
                            Navigator.of(context).pushNamed('/admin_home');
                          } else if (_formKey.currentState.validate()) {
                            dynamic result =
                                await _auth.signInEmailPwd(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Could not sign in';
                              });
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Text('Create an Account?'),
                onTap: () {
                  widget.changeView();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
