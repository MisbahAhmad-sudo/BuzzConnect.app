import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/config/images.dart';
import 'package:final_project/controller/groupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/chatTile.dart';
import '../../../config/customMessages.dart';
import '../../../controller/imagePickerController.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    RxString groupName = "".obs;
    GroupController groupController = Get.put(GroupController());
    ImagePickerController imagePickerController =
    Get.put(ImagePickerController());
    RxString imagePath = "".obs;
    return Scaffold(
      appBar: AppBar(
        title: const Text('new group'),
        backgroundColor: Colors.purple,
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
        backgroundColor: groupName.value.isEmpty ? Colors.grey : Colors.purple,
        onPressed: () async {
          if (groupName.value.isNotEmpty) {
            bool create = await groupController.CreateGroup(groupName.value, imagePath.value);
            if (create) {
              succesMessage("Group Created");
            /*  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              ); */
              Get.offAllNamed("/homePage");
            }
          } else {
            // Show pop-up message using showDialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Please enter group name"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Get.back();
                        //Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: groupController.isLoading.value ?
        const CircularProgressIndicator(
          color: Colors.white,
        ) : const Icon(Icons.done, color: Colors.white,),
      ),),

      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.purple,
            ),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Obx(() => InkWell(
                      onTap: () async {
                        imagePath.value =
                        await imagePickerController
                            .pickImage(ImageSource.gallery);
                        print("image path" + imagePath.value);
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white54,
                        ),
                        child: imagePath.value == "" ?
                        const Icon(Icons.group, size: 40,):
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                         child: Image.file(File(imagePath.value,), fit: BoxFit.cover,)),
                      ),
                    ),),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value){
                        groupName.value=value;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        fillColor: Colors.grey[100],
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        hintText: "Group Name",
                        prefixIcon:Icon(Icons.group),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: groupController.groupMembers
                  .map((e) => ChatTile(
                      userName: e.name!,
                      lastChat: e.about ?? "",
                      onTap: () {},
                      imageUrl: e.profileImage ?? AssetsImage.defaultProfileUrl,
                      lastTime: Timestamp.now()))
                  .toList(),
            ),
          ))
        ],
      ),
    );
  }
}
