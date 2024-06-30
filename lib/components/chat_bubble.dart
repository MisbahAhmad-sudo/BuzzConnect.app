import 'package:final_project/components/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../config/images.dart';
import 'audio_player_widget.dart';
import 'full_screen_image.dart';
import 'full_screen_video.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final Timestamp messageTime;
  final String imageUrl;
  final String videoUrl;
  final String audioUrl;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    required this.messageTime,
    required this.imageUrl,
    required this.videoUrl ,
    required this.audioUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert Timestamp to DateTime
    DateTime dateTime = messageTime.toDate();
    if (videoUrl.isNotEmpty)
       { print("url in chat bubble"+videoUrl);};
    // Format the time with AM/PM
    String formattedTime = DateFormat.jm().format(dateTime);
    return Column(
      crossAxisAlignment:
      isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width / 1.3,
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isCurrentUser ? Colors.purple : Colors.white,
          ),
          child: Column(
            children: [
              if (imageUrl.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    Get.to(FullScreenImage(imageUrl:imageUrl));
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(imageUrl: imageUrl),
                      ),
                    );*/
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(imageUrl),
                  ),
                ),
              if (videoUrl.isNotEmpty)
                VideoPlayerWidget(
                  videoUrl: videoUrl,
                  onFullScreenTap: () {
                    Get.to(FullScreenVideo(videoUrl: videoUrl));
                  },
                ),
              if (audioUrl.isNotEmpty)
                AudioPlayerWidget(audioUrl: audioUrl),
              if (message.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 18,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ],
          ),
        ),
        Row(
          mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (isCurrentUser)
              Row(
                children: [
                  Text(
                    formattedTime,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    AssetsImage.doubleTick,
                    color: Colors.purpleAccent,
                    width: 30,
                  ),
                ],
              )
            else
              Text(
                formattedTime,
                style: Theme.of(context).textTheme.labelMedium,
              ),
          ],
        ),
      ],
    );
  }
}

