import 'package:final_project/components/chatTile.dart';
import 'package:final_project/controller/contactController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/images.dart';
import '../controller/profileController.dart';
import 'chat_page.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    return RefreshIndicator(
      child: Obx(() => ListView(
        children: contactController.chatRoomList
            .map((e) => InkWell(
          child: ChatTile(
            lastChat: e.lastMessage ?? "User Message",
            onTap: () {
             /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                      targetUser: (e.receiver!.uid ==
                                profileController.currentUser.value.uid
                            ? e.sender
                            : e.receiver)!,
                  ),
                ),
              );*/
              Get.to( ChatPage(
                targetUser: (e.receiver!.uid ==
                    profileController.currentUser.value.uid
                    ? e.sender
                    : e.receiver)!,
              ),);
            },
            imageUrl: (e.receiver!.uid ==
                profileController.currentUser.value.uid
                ? e.sender!.profileImage
                : e.receiver!.profileImage) ??
                AssetsImage.defaultProfileUrl,
            userName: (e.receiver!.uid ==
                profileController.currentUser.value.uid
                ? e.sender!.name
                : e.receiver!.name)!,
            lastTime: e.lastMessageTimestamp!,
          ),
        ))
            .toList(),
      )),
      onRefresh: (){
        return contactController.getChatRoomList();
      },
    );
  }
}
