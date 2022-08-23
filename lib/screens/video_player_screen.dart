import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';

import 'package:ott_asper_hackathon/reusables/reusable_widgets.dart';
import 'signin_screen.dart';

String webLink = '';
File? file = null;

class OnlineVideoPlayerScreen extends StatefulWidget {
  OnlineVideoPlayerScreen({Key? key, required String link}) : super(key: key) {
    webLink = link;
  }

  @override
  State<OnlineVideoPlayerScreen> createState() =>
      _OnlineVideoPlayerScreenState();
}

class _OnlineVideoPlayerScreenState extends State<OnlineVideoPlayerScreen> {
  VideoPlayerController? onlineVideoController;
  String url = webLink;

  @override
  void initState() {
    super.initState();
    onlineVideoController = VideoPlayerController.network(url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize()
          .then((_) => onlineVideoController!.play())
          .onError((error, stackTrace) => print('ERROR $error'));
  }

  @override
  void dispose() {
    onlineVideoController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = onlineVideoController!.value.volume == 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Video Player',
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
                      (route) => false,
                    );
                  });
                },
                child: Icon(Icons.logout),
              ),
            ),
          ],
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: VideoPlayerWidget(controller: onlineVideoController),
              ),
              if (onlineVideoController != null &&
                  onlineVideoController!.value.isInitialized)
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.yellow[300],
                  child: IconButton(
                    icon: Icon(
                      isMuted ? Icons.volume_mute : Icons.volume_up,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      onlineVideoController!.setVolume(isMuted ? 1 : 0);
                    },
                  ),
                ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FileVideoPlayer extends StatefulWidget {
  FileVideoPlayer({Key? key, required File filePath}) : super(key: key) {
    file = filePath;
  }

  @override
  State<FileVideoPlayer> createState() => _FileVideoPlayerState();
}

class _FileVideoPlayerState extends State<FileVideoPlayer> {
  VideoPlayerController? fileVideoController;

  @override
  void initState() {
    super.initState();
    fileVideoController = VideoPlayerController.file(file!)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize()
          .then((_) => fileVideoController!.play())
          .onError((error, stackTrace) => print('$error'));
  }

  @override
  void dispose() {
    fileVideoController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = fileVideoController!.value.volume == 0;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[200],
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Video Player',
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
                        (route) => false,
                      );
                    });
                  },
                  child: Icon(Icons.logout),
                ),
              ),
            ],
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: VideoPlayerWidget(controller: fileVideoController),
                ),
                SizedBox(
                  height: 20,
                ),
                if (fileVideoController != null &&
                    fileVideoController!.value.isInitialized)
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.yellow[300],
                    child: IconButton(
                      icon: Icon(
                        isMuted ? Icons.volume_mute : Icons.volume_up,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        fileVideoController!.setVolume(isMuted ? 1 : 0);
                      },
                    ),
                  ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }
}
