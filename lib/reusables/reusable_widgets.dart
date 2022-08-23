import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:ott_asper_hackathon/screens/signup_screen.dart';

Image imageWidget1(String address) {
  return Image(
    image: AssetImage(address),
    height: 240,
    width: 240,
  );
}

Image imageWidget2(String address) {
  return Image(
    image: AssetImage(address),
    color: Colors.blueAccent.shade700,
    height: 100,
    width: 100,
  );
}

Text reusableText1(String text, Color color, double size) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text reusableText2(String text, Color color, double size) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.indigoAccent.shade700),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.blueAccent.shade200,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.blueAccent.shade200),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.5),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function? onTap()) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: onTap,
      child: Text(
        isLogin ? 'LOG IN!' : 'SIGN UP!',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.yellow[900];
          }
          return Colors.yellow[300];
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    ),
  );
}

Container reusableButton(
    BuildContext context, Function? onTap(), String label) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.yellow[900];
          }
          return Colors.yellow[300];
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    ),
  );
}

Column sigUpOption(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Dont\' have an account? \t ',
        style: TextStyle(
            color: Colors.blueAccent.shade200, fontWeight: FontWeight.bold),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Text(
          'Sign Up!',
          style: TextStyle(
            color: Colors.blueAccent.shade400,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController? controller;

  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (controller == null && !(controller!.value.isInitialized))
        ? Container(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: buildVideo(),
          );
  }

  Widget buildVideo() {
    return Stack(
      children: [
        buildVideoPlayer(),
        Positioned.fill(
          child: BasicOverlayWidget(controller: controller!),
        ),
      ],
    );
  }

  Widget buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: VideoPlayer(controller!),
    );
  }
}

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController? controller;
  const BasicOverlayWidget(
      {Key? key, required VideoPlayerController this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        controller!.value.isPlaying ? controller!.pause() : controller!.play();
      },
      child: Stack(
        children: [
          Positioned(
            child: buildIndicator(),
            bottom: 0,
            left: 0,
            right: 0,
          ),
          buildPlay(),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return VideoProgressIndicator(controller!, allowScrubbing: true);
  }

  Widget buildPlay() {
    return (controller!.value.isPlaying)
        ? Container()
        : Container(
            alignment: Alignment.center,
            color: Colors.black26,
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 30,
            ),
          );
  }
}
