import 'dart:io';
import 'package:final_project/controller/imagePickerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/my_button.dart';
import '../../controller/profileController.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    RxBool isEdit = false.obs;
    final TextEditingController nameController =
        TextEditingController(text: profileController.currentUser.value.name);
    final TextEditingController emailController =
        TextEditingController(text: profileController.currentUser.value.email);
    final TextEditingController phoneController = TextEditingController(
        text: profileController.currentUser.value.phoneNumber);
    final TextEditingController aboutController =
        TextEditingController(text: profileController.currentUser.value.about);
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = "".obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => isEdit.value
                                  ? InkWell(
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
                                          color: Colors.white38,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: imagePath.value == ""
                                            ? const Icon(Icons.add)
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.file(
                                                  File(imagePath.value),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ))
                                  : Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white38,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: profileController.currentUser.value
                                                      .profileImage ==
                                                  null ||
                                              profileController.currentUser
                                                      .value.profileImage ==
                                                  ""
                                          ? Icon(Icons.image)
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child:Image.network(
                                                profileController.currentUser.value.profileImage!,
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => TextField(
                            controller: nameController,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              filled: isEdit.value,
                              prefixIcon: const Icon(
                                Icons.person,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: emailController,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            filled: isEdit.value,
                            prefixIcon: const Icon(
                              Icons.alternate_email,
                            ),
                          ),
                        ),
                        Obx(
                          () => TextField(
                            controller: aboutController,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              labelText: 'About',
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              filled: isEdit.value,
                              prefixIcon: const Icon(
                                Icons.info,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => TextField(
                            controller: phoneController,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              labelText: 'Number',
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              filled: isEdit.value,
                              prefixIcon: const Icon(
                                Icons.phone,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Obx(
                            () => isEdit.value
                                ? MyButton(
                                    text: 'Save',
                                    onTap: () async {
                                      //store data in database
                                      await profileController.updateProfile(
                                          imagePath.value,
                                          nameController.text,
                                          aboutController.text,
                                          phoneController.text);
                                      isEdit.value = false;
                                    },
                                    color: Colors.white,
                                  )
                                : MyButton(
                                    text: 'Edit',
                                    onTap: () {
                                      isEdit.value = true;
                                    },
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
