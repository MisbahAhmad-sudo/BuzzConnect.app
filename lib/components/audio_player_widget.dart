import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _audioDuration = Duration.zero;
  Duration _audioPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    await _audioPlayer.setUrl(widget.audioUrl);
    _audioDuration = await _audioPlayer.duration ?? Duration.zero;
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _audioPosition = position;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6, // Adjust the width as needed
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 3.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProgressBar(
            progress: _audioPosition,
            buffered: Duration.zero,
            total: _audioDuration,
            onSeek: (duration) {
              _audioPlayer.seek(duration);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: () {
                  if (_audioPlayer.playing) {
                    _audioPlayer.pause();
                  } else {
                    _audioPlayer.play();
                  }
                },
              ),
              Text(
                "${_audioPosition.inMinutes}:${_audioPosition.inSeconds.remainder(60).toString().padLeft(2, '0')} / ${_audioDuration.inMinutes}:${_audioDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
