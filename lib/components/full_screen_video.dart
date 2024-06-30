import 'dart:io';  // Ensure this import is present
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideo extends StatefulWidget {
  final String videoUrl;
  final bool isNetwork;

  const FullScreenVideo({Key? key, required this.videoUrl, this.isNetwork = true}) : super(key: key);

  @override
  _FullScreenVideoState createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  late VideoPlayerController _videoPlayerController;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    if (widget.isNetwork) {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..initialize().then((_) {
          setState(() {}); // Ensure the first frame is shown after the video is initialized
          _videoPlayerController.play(); // Start playing the video
        });
    } else {
      _videoPlayerController = VideoPlayerController.file(File(widget.videoUrl))
        ..initialize().then((_) {
          setState(() {}); // Ensure the first frame is shown after the video is initialized
          _videoPlayerController.play(); // Start playing the video
        });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      } else {
        _videoPlayerController.play();
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
                  : CircularProgressIndicator(),
            ),
            if (_showControls)
              Center(
                child: IconButton(
                  iconSize: 64.0,
                  icon: Icon(
                    _videoPlayerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: _togglePlayPause,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
