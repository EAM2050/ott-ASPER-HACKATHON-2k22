import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ott_asper_hackathon/screens/asset_video_player_screen.dart';

import 'package:ott_asper_hackathon/screens/ott_content_screen.dart';
import 'package:ott_asper_hackathon/screens/signin_screen.dart';
import 'package:ott_asper_hackathon/reusables/reusable_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> userData =
      FirebaseFirestore.instance.collection('UsersData').snapshots();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final email = user!.email;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Homescreen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[900],
              ),
            ),
            Container(
              height: 50,
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print('Signed Out');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                        (route) => false);
                  });
                },
                child: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: userData,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(
              "<ERROR>",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comic',
                fontSize: 40,
                color: Colors.red[900],
                fontWeight: FontWeight.bold,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List storeData = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storeData.add(a);
          }).toList();
          int i = 0;
          for (; i < storeData.length; i++) {
            if (storeData[i]['email'] == email!) {
              break;
            }
          }
          return Container(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 100,
                      foregroundImage:
                          AssetImage('assets/images/abstract_user.png'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      storeData[i]['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Comic',
                        fontSize: 40,
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    Card(
                      color: Colors.yellow[300],
                      child: ListTile(
                        leading: Icon(
                          Icons.contact_phone,
                          size: 30,
                          color: Colors.deepPurple[900],
                        ),
                        title: Text(
                          '+91 ${storeData[i]['phone_number']}',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                    ),
                    Card(
                      color: Colors.yellow[300],
                      child: ListTile(
                        leading: Icon(
                          Icons.email,
                          size: 30,
                          color: Colors.deepPurple[900],
                        ),
                        title: Text(
                          storeData[i]['email'],
                          style: TextStyle(
                            color: Colors.red[700],
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                    ),
                    reusableButton(context, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTTContentScreen()));
                    }, 'Goto My Top Picks'),
                    reusableButton(context, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssetVideoPlayer()));
                    }, "Play a Random Video!"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
