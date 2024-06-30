import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/imagePickerController.dart';
import '../controller/chatController.dart';
import 'dart:io';

class ImagePickerBottomSheet extends StatelessWidget {
  final ChatController chatController = Get.find();
  final ImagePickerController imagePickerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              String imagePath = await imagePickerController.pickImage(ImageSource.camera);
              if (imagePath.isNotEmpty) {
                chatController.selectedImagePath.value = imagePath;
                chatController.selectedVideoPath.value = ""; // Clear video path
              }
              Get.back();
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.camera, size: 30,),
            ),
          ),
          InkWell(
            onTap: () async {
              String imagePath = await imagePickerController.pickImage(ImageSource.gallery);
              if (imagePath.isNotEmpty) {
                chatController.selectedImagePath.value = imagePath;
                chatController.selectedVideoPath.value = ""; // Clear video path
              }
              Get.back();
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.photo, size: 30,),
            ),
          ),
          InkWell(
            onTap: () async {
              String videoPath = await imagePickerController.pickVideo(ImageSource.gallery);
              if (videoPath.isNotEmpty) {
                chatController.selectedVideoPath.value = videoPath;
                chatController.selectedImagePath.value = ""; // Clear image path
              }
              Get.back();
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.play_arrow, size: 30,),
            ),
          ),
        ],
      ),
    );
  }
}
