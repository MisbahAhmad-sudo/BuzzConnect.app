import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/components/chatTile.dart';
import 'package:final_project/controller/groupController.dart';
import 'package:final_project/pages/Gropup/NewGroup/groupTittle.dart';
import 'package:final_project/pages/Gropup/NewGroup/selectedMembers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/images.dart';
import '../../../controller/contactController.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Groups"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.purple,
      ),
      floatingActionButton:Obx(()=>  FloatingActionButton(
        backgroundColor:groupController.groupMembers.isEmpty? Colors.grey: Colors.purple ,
        onPressed: () {
          if(groupController.groupMembers.isEmpty){
            Get.snackbar("Error", "Please select at-least one member");
          }
          else{
           /* Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GroupTitle(),
              ),
            );*/
            Get.to(GroupTitle());
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SelectedMembers(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Contacts on BuzzConnect",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: contactController.getContacts(),
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
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ChatTile(
                            userName: snapshot.data![index].name!,
                            lastChat: snapshot.data![index].email!,
                            onTap: () {
                              groupController
                                  .selectMember(snapshot.data![index]);
                            },
                            imageUrl: snapshot.data![index].profileImage ??
                                AssetsImage.defaultProfileUrl,
                            lastTime: Timestamp.now());
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
