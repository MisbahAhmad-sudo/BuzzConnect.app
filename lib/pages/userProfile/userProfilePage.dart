import 'package:final_project/model/UserModel.dart';
import 'package:final_project/pages/profile/widgets/loginUserInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/images.dart';
import 'UserUpdateProfile.dart';


class UserProfilePage extends StatelessWidget {
  final UserModel? userModel;
  const UserProfilePage({Key? key, this.userModel});

  @override
  Widget build(BuildContext context) {
    // Check if userModel is null before accessing its properties
    final profileImage = userModel?.profileImage ?? AssetsImage.defaultProfileUrl;
    final userName = userModel?.name ?? "Users";
    final userEmail = userModel?.email ?? "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Profile'),
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
            icon: const Icon(Icons.edit,),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LoginUserInfo(profileImage: profileImage, userName: userName, userEmail: userEmail),
            ],
          ),
        ),
      ),
    );
  }
}

