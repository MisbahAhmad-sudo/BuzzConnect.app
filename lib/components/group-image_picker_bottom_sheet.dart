import 'package:final_project/controller/groupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/imagePickerController.dart';

class GroupImagePickerBottomSheet extends StatelessWidget {
  final GroupController groupController= Get.find();
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
              groupController.selectedImagePath.value =
              await imagePickerController.pickImage(ImageSource.camera);
              //Navigator.pop(context); // Close the bottom sheet after selection
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
              groupController.selectedImagePath.value =
              await imagePickerController.pickImage(ImageSource.gallery);
              //Navigator.pop(context); // Close the bottom sheet after selection
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
            onTap: () {},
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
