import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ott_asper_hackathon/reusables/reusable_widgets.dart';
import 'package:ott_asper_hackathon/screens/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  String message = 'Please enter your Credentials \n to Sign into your Account';
  Color messagae_font_color = Colors.purple[900]!;
  double message_font_size = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        elevation: 0,
        title: Text(
          'Sign In',
          style: TextStyle(
              color: Colors.indigo.shade900,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffF48FB1),
              Color(0xffF9CB9C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.15, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                reusableText1(message, messagae_font_color, message_font_size),
                imageWidget1('assets/images/ott_app_icon.png'),
                SizedBox(
                  height: 30,
                ),
                reusableTextField('Enter Username/Email ID', Icons.person,
                    false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField('Enter Password', Icons.lock, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print('Signed In');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).onError((error, stackTrace) {
                    print('Error $error');
                    setState(() {
                      if (error.toString() ==
                          '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
                        message =
                            'NETWORK ERROR! \n Please check your Internet connection...';
                        messagae_font_color = Colors.redAccent[700]!;
                        message_font_size = 18.0;
                      } else {
                        message =
                            'Please enter your Credentials \n to Sign into your Account \n PLEASE ENTER CORRECT CREDENTIALS FOR SIGN IN! \n Else, Sign Up...';
                        messagae_font_color = Colors.redAccent[700]!;
                        message_font_size = 16.0;
                      }
                    });
                  });
                }),
                SizedBox(
                  height: 30,
                ),
                sigUpOption(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
