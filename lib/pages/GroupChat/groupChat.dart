import 'dart:io';
import 'package:final_project/components/chat_bubble.dart';
import 'package:final_project/config/images.dart';
import 'package:final_project/controller/groupController.dart';
import 'package:final_project/controller/imagePickerController.dart';
import 'package:final_project/controller/profileController.dart';
import 'package:final_project/model/GroupModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/group-image_picker_bottom_sheet.dart';
import '../Gropup/GroupInfo/groupProfilePage.dart';


class GroupChatPage extends StatefulWidget {
  final GroupModel groupModel;

  const GroupChatPage({
    super.key,
    required this.groupModel,
  });

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final TextEditingController _messageController = TextEditingController();
  ProfileController profileController = Get.put(ProfileController());
  RxString message = "".obs;
  ImagePickerController imagePickerController =
  Get.put(ImagePickerController());
  GroupController groupController = Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
    final profileImage = widget.groupModel.profileUrl == ""
        ? AssetsImage.defaultProfileUrl
        : widget.groupModel.profileUrl!;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
         /*  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupProfilePage( groupModel: widget.groupModel),
              ),
            );*/
            Get.to(GroupProfilePage( groupModel: widget.groupModel));

          },
          child: Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Container(
              width: 60, // Increased width for the container
              height: 60, // Increased height for the container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.white, // Change the color as needed
                  width: 2, // Adjust the width of the border
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  profileImage,
                  fit: BoxFit
                      .cover, // Use BoxFit.cover to ensure the image fills the container without being distorted
                ),
              ),
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
           /* Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupProfilePage(
                  groupModel: widget.groupModel,
                ),
              ),
            );*/
            Get.to(GroupProfilePage(groupModel: widget.groupModel));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.groupModel.name == "" ? "Name": widget.groupModel.name! ,
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(
                    "online",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {},
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
            stream: groupController.getGroupMessage(widget.groupModel.id!),
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
                      imageUrl:snapshot.data![index].imageUrl ?? "" ,
                      videoUrl: snapshot.data![index].videoUrl ?? "",
                      audioUrl: snapshot.data![index].audioUrl ?? "",
                      isCurrentUser: snapshot.data![index].senderId ==
                          profileController.currentUser.value.uid,
                      messageTime: snapshot.data![index].timestamp!);
                },
              );
            }),
        Obx(() => groupController.selectedImagePath.value != ""
            ? Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Stack(
            children: [
              Image.file(
                File(groupController.selectedImagePath.value),
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.5, // Adjust the height as needed
                width: double.infinity, // Take the full width of the screen
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {
                    groupController.selectedImagePath.value="";
                  },
                  icon: const Icon(Icons.close),
                ),
              )
            ],
          ),
        )
            : Container())

      ],
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          // textField with camera and more icons
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
                    prefixIcon: const Icon(Icons.emoji_emotions),
                  ),
                ),
                Positioned(
                  right: 48,
                  bottom: 8,
                  child: IconButton(
                    onPressed: () {
                      // Handle more icon pressed
                      // Add your more icon functionality here
                    },
                    icon: const Icon(Icons.more_horiz_outlined),
                  ),
                ),
                Positioned(
                    right: 8,
                    bottom: 8,
                    child: Obx(
                          () => groupController.selectedImagePath.value == ""
                          ? IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return GroupImagePickerBottomSheet();
                            },
                          );                        },
                        icon: const Icon(Icons.camera_alt),
                      )
                          :const SizedBox(),
                    )),
              ],
            ),
          ),
          // send button (mic or arrow)
          Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),
            child: Obx(
                  () => message.value != "" || groupController.selectedImagePath.value !=""
                  ?IconButton(
                onPressed: () {
                  groupController.sendGroupMessage(_messageController.text, widget.groupModel.id!,);
                  _messageController.clear();
                  message.value = "";
                },
                icon: groupController.isLoading.value ? const CircularProgressIndicator():const Icon(
                  Icons.arrow_upward,
                  size: 40,
                  color: Colors.white,
                ) ,
              )
                  :IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mic,
                    size: 40,
                    color: Colors.white,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
