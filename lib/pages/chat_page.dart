import 'dart:io';
import 'package:final_project/components/chat_bubble.dart';
import 'package:final_project/config/images.dart';
import 'package:final_project/controller/callController.dart';
import 'package:final_project/controller/chatController.dart';
import 'package:final_project/controller/imagePickerController.dart';
import 'package:final_project/controller/profileController.dart';
import 'package:final_project/pages/userProfile/userProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/emoji_picker_widget.dart';
import '../components/image_picker_bottom_sheet.dart';
import '../components/video_player_widget.dart';
import '../controller/voice_message_controller.dart';
import '../model/UserModel.dart';
import 'callPage/audioCallPage.dart';
import 'callPage/videoCallPage.dart';

class ChatPage extends StatefulWidget {
  final UserModel targetUser;

  const ChatPage({
    super.key,
    required this.targetUser,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  ChatController chatController = Get.put(ChatController());
  ProfileController profileController = Get.put(ProfileController());
  RxString message = "".obs;
  ImagePickerController imagePickerController = Get.put(ImagePickerController());
  RxString imagePath = "".obs;
  CallController callController = Get.put(CallController());
  VoiceMessageController voiceMessageController = Get.put(VoiceMessageController());
  bool _showEmoji = false;

  void _onBackspacePressed() {
    _messageController
      ..text = _messageController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _messageController.text.length),
      );
  }


  @override
  Widget build(BuildContext context) {
    final profileImage = widget.targetUser.profileImage ?? AssetsImage.defaultProfileUrl;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.to(() => UserProfilePage(
              userModel: widget.targetUser,
            ));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  profileImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfilePage(
              userModel: widget.targetUser,
            ));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.targetUser.name!,
                      style: Theme.of(context).textTheme.headlineMedium),
                  //show status of user
                  StreamBuilder(
                      stream: chatController.getStatus(widget.targetUser.uid!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("...........................");
                        } else {
                          return Text(
                            snapshot.data!.status ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              color: snapshot.data!.status == "Online"
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          );
                        }
                      })
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(AudioCallPage(target: widget.targetUser,));
              callController.callAction(
                  widget.targetUser, profileController.currentUser.value, "audio");
            },
            icon: const Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => VideoCallPage(target: widget.targetUser,));
              callController.callAction(
                  widget.targetUser, profileController.currentUser.value, "video");
            },
            icon: const Icon(Icons.video_call),
          ),
        ],
      ),
      body: Column(
        children: [
          //Message
          Expanded(
            child: _buildMessageList(),
          ),

          //userInput
          _buildMessageInput(),
          if (_showEmoji)
            EmojiPickerWidget(
              controller: _messageController,
              onBackspacePressed: _onBackspacePressed,
            ),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return Stack(
      children: [
        StreamBuilder(
            stream: chatController.getMessages(widget.targetUser.uid!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Errors${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading....');
              }
              if (snapshot.data == null) {
                return const Center(
                  child: Text("No Messages"),
                );
              }
              return ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                      message: snapshot.data![index].message!,
                      imageUrl: snapshot.data![index].imageUrl ?? "",
                      videoUrl: snapshot.data![index].videoUrl ?? "",
                      audioUrl: snapshot.data![index].audioUrl ?? "",
                      isCurrentUser: snapshot.data![index].receiverId! !=
                          profileController.currentUser.value.uid,
                      messageTime: snapshot.data![index].timestamp!);
                },
              );
            }),
        Obx(() {
          if (chatController.selectedImagePath.value != "" || chatController.selectedVideoPath.value != "") {
            return Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Stack(
                children: [
                  if (chatController.selectedImagePath.value != "")
                    Image.file(
                      File(chatController.selectedImagePath.value),
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                    ),
                  if (chatController.selectedVideoPath.value != "")
                    VideoPlayerWidget(
                      videoUrl: chatController.selectedVideoPath.value,
                      isNetwork: false,
                    ),

                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        chatController.clearSelectedFile();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        })
      ],
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                TextField(
                  onChanged: (value) {
                    message.value = value;
                  },
                  controller: _messageController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    fillColor: Colors.grey[100],
                    filled: false,
                    hintText: "Enter Message...",
                    hintStyle: const TextStyle(color: Colors.black),
                    prefixIcon:  GestureDetector(
                      onTap: () {
                        setState(() {
                          _showEmoji = !_showEmoji;
                        });
                      },
                      child: const Icon(
                        Icons.emoji_emotions,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 48,
                  bottom: 8,
                  child: IconButton(
                    onPressed: () {
                      // Handle more icon pressed
                    },
                    icon: const Icon(Icons.more_horiz_outlined),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Obx(
                        () => chatController.selectedImagePath.value == "" && chatController.selectedVideoPath.value == ""
                        ? IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ImagePickerBottomSheet();
                          },
                        );
                      },
                      icon: const Icon(Icons.camera_alt),
                    )
                        : const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),
            child: Obx(
                  () => message.value != "" || chatController.selectedImagePath.value != "" || chatController.selectedVideoPath.value != ""
                  ? IconButton(
                onPressed: () {
                  if (_messageController.text.isNotEmpty ||
                      chatController.selectedImagePath.value.isNotEmpty ||
                      chatController.selectedVideoPath.value.isNotEmpty) {
                    chatController.sendMessage(
                      widget.targetUser.uid!,
                      _messageController.text,
                      widget.targetUser,
                    );
                    _messageController.clear();
                    message.value = "";
                    chatController.clearSelectedFile();
                  }
                },
                icon: chatController.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Icon(
                  Icons.arrow_upward,
                  size: 40,
                  color: Colors.white,
                ),
              )
                  : IconButton(
                      onPressed: () async {
                        if (voiceMessageController.isRecording.value) {
                          String? audioUrl = await voiceMessageController.stopRecordingAndUpload(widget.targetUser.uid!);
                          if (audioUrl != null) {
                            chatController.sendAudioMessage(widget.targetUser.uid!, audioUrl, widget.targetUser);
                          }
                        } else {
                          await voiceMessageController.startRecording();
                        }
                      },
                  icon:  Icon(
                    voiceMessageController.isRecording.value ? Icons.stop : Icons.mic,
                    size: 40,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

