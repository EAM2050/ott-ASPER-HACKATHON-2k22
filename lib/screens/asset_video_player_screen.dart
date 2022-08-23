import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';

import 'package:ott_asper_hackathon/reusables/reusable_widgets.dart';
import 'signin_screen.dart';

class AssetVideoPlayer extends StatefulWidget {
  const AssetVideoPlayer({Key? key}) : super(key: key);

  @override
  State<AssetVideoPlayer> createState() => _AssetVideoPlayerState();
}

class _AssetVideoPlayerState extends State<AssetVideoPlayer> {
  VideoPlayerController? assetVideoController;

  @override
  void initState() {
    super.initState();
    assetVideoController =
        VideoPlayerController.asset('assets/videos/Dicee_App_2.mp4')
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize().then((_) => assetVideoController!.play());
  }

  @override
  void dispose() {
    assetVideoController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = assetVideoController!.value.volume == 0;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[200],
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Example Video...',
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
                  child: VideoPlayerWidget(controller: assetVideoController),
                ),
                SizedBox(
                  height: 20,
                ),
                if (assetVideoController != null &&
                    assetVideoController!.value.isInitialized)
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.yellow[300],
                    child: IconButton(
                      icon: Icon(
                        isMuted ? Icons.volume_mute : Icons.volume_up,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        assetVideoController!.setVolume(isMuted ? 1 : 0);
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
