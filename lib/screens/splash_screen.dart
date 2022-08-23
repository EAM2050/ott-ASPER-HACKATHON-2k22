import 'package:flutter/material.dart';

import 'package:ott_asper_hackathon/reusables/reusable_widgets.dart';
import 'package:ott_asper_hackathon/screens/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'WELCOME',
            style: TextStyle(
              color: Colors.indigo.shade900,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 10,
            ),
          ),
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
                20, MediaQuery.of(context).size.height * 0.18, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Now You\'re \nOVER THE TOP!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.purple.shade900,
                  ),
                ),
                imageWidget1('assets/images/ott_app_icon.png'),
                Text(
                  'We\'re here to provide you with the \n Best Curated OTT Content!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                reusableButton(context, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                }, 'Let\'s SIGN IN!'),
                SizedBox(
                  height: 50,
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
