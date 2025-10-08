import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset("assets/videos/babyvideo.mp4")
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    _timer = Timer(const Duration(seconds: 6), _checkDataAndNavigate);
  }

  Future<void> _checkDataAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final babyName = prefs.getString("baby_name");
    final babyDob = prefs.getString("baby_dob");

    if (!mounted) return;

    if (babyName != null && babyDob != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            _controller.value.isInitialized
                ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
                : const CircularProgressIndicator(),
      ),
    );
  }
}
