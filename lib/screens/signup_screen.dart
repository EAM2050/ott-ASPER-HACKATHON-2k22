import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ott_asper_hackathon/screens/home_screen.dart';
import 'package:ott_asper_hackathon/reusables/reusable_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  CollectionReference users =
      FirebaseFirestore.instance.collection('UsersData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        elevation: 0,
        title: Text(
          'Sign Up',
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
                reusableText1(
                    'Please create your Credentials \n to Create your OTT Account',
                    Colors.purple[900]!,
                    14),
                SizedBox(
                  height: 30,
                ),
                imageWidget2('assets/images/handshake_logo.png'),
                SizedBox(
                  height: 30,
                ),
                reusableTextField(
                    'Enter your Name', Icons.title, false, _nameTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField('Enter your Phone number',
                    Icons.phone_android_rounded, false, _phoneNumberController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField('Create Username (your Email ID)',
                    Icons.person_outline, false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField('Create Password', Icons.lock_outline_rounded,
                    true, _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, false, () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) async {
                    print('Signed Up');
                    await users.add({
                      'name': _nameTextController.text,
                      'email': _emailTextController.text,
                      'password': _passwordTextController.text,
                      'phone_number': _phoneNumberController.text
                    }).then((value) => print('UsersData Updated'));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).onError((error, stackTrace) {
                    print('Error ${error.toString()}');
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
