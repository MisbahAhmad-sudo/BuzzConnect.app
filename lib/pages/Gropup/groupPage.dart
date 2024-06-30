import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/components/chatTile.dart';
import 'package:final_project/controller/groupController.dart';
import 'package:final_project/pages/GroupChat/groupChat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/images.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    return Obx(() => ListView(
      children: groupController.groupList
          .map((group) => ChatTile(
          userName: group.name == "" ? "name": group.name!,
          lastChat: "group created",
          onTap: () {
         /*  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupChatPage(groupModel: group,)
              ),
            );*/
            Get.to(GroupChatPage(groupModel: group));

          },
          imageUrl: group.profileUrl == ""
              ? AssetsImage.defaultProfileUrl
              : group.profileUrl!,
          lastTime: Timestamp.now()))
          .toList(),
    ));
  }
}
