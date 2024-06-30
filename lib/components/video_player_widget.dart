import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool isNetwork; // Flag to determine if the video is from network or file
  final VoidCallback? onFullScreenTap; // Add callback for full-screen tap

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    this.isNetwork = true,
    this.onFullScreenTap,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    if (widget.isNetwork) {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..initialize().then((_) {
          setState(() {}); // Ensure the first frame is shown after the video is initialized
        });
    } else {
      _videoPlayerController = VideoPlayerController.file(File(widget.videoUrl))
        ..initialize().then((_) {
          setState(() {}); // Ensure the first frame is shown after the video is initialized
        });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized
        ? AspectRatio(
      aspectRatio: _videoPlayerController.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          VideoPlayer(_videoPlayerController),
          _ControlsOverlay(
            controller: _videoPlayerController,
            onFullScreenTap: widget.onFullScreenTap, // Pass the callback
          ),
        ],
      ),
    )
        : Center(child: CircularProgressIndicator());
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller, this.onFullScreenTap}) : super(key: key);

  static const _iconSize = 30.0;
  final VideoPlayerController controller;
  final VoidCallback? onFullScreenTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (!controller.value.isPlaying)
          Container(
            color: Colors.black26,
            child: Center(
              child: GestureDetector(
                onTap: onFullScreenTap,
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: _iconSize,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
