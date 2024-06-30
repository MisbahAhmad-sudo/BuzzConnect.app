import 'package:final_project/components/user_tile.dart';
import 'package:final_project/model/GroupModel.dart';
import 'package:final_project/pages/profile/widgets/groupMemberInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/images.dart';
import '../../userProfile/UserUpdateProfile.dart';

class GroupProfilePage extends StatelessWidget {
  final GroupModel? groupModel;
  const GroupProfilePage({Key? key, this.groupModel});

  @override
  Widget build(BuildContext context) {
    // Check if userModel is null before accessing its properties
    final profileImage =
        groupModel?.profileUrl =="" ? AssetsImage.defaultProfileUrl:groupModel?.profileUrl ;
    final userName = groupModel?.name ?? "Users";
    final userEmail = groupModel?.description ?? "No Description is available";
    final groupId= groupModel?.id;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Group Profile'),
        actions: [
          IconButton(
            onPressed: () {
             /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserUpdateProfile(),
                ),
              );*/
              Get.offAllNamed("/userUpdateProfile");
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            GroupMembersInfo(
                profileImage: profileImage!,
                groupId: groupId!,
                userName: userName,
                userEmail: userEmail),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Memebers",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: groupModel!.members!
                  .map((member) => UserTile(
                      userName: member.name!,
                      userEmail: member.email!,
                      role: member.role == "admin" ? "Admin": "User",
                      onTap: () {},
                      imageUrl:
                          member.profileImage ?? AssetsImage.defaultProfileUrl))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
