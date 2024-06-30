import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/images.dart';
import '../../../controller/groupController.dart';

class SelectedMembers extends StatelessWidget {
  const SelectedMembers({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    return Obx(
          () => Row(
        children: groupController.groupMembers
            .map((e) => Stack(children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                e.profileImage ?? AssetsImage.defaultProfileUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: (){
                groupController.groupMembers.remove(e);
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],))
            .toList(),
      ),
    );
  }
}
