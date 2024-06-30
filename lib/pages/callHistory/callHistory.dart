import 'package:final_project/components/chatTile.dart';
import 'package:final_project/config/images.dart';
import 'package:final_project/controller/chatController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallHistory extends StatelessWidget {
  const CallHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return StreamBuilder(
        stream: chatController.getCalls(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  if (snapshot.data![index].callerUid ==
                      _auth.currentUser!.uid) {
                    return ChatTile(
                      userName: snapshot.data![index].receiverName ?? "",
                      lastChat: snapshot.data![index].time ?? "",
                      onTap: () {},
                      imageUrl: snapshot.data![index].receiverPic ??
                          AssetsImage.defaultProfileUrl,
                      lastTime: snapshot.data![index].timestamp!,
                    );
                  } else {
                    return ChatTile(
                      userName: snapshot.data![index].callerName ?? "",
                      lastChat: snapshot.data![index].time ?? "",
                      onTap: () {},
                      imageUrl: snapshot.data![index].callerPic ??
                          AssetsImage.defaultProfileUrl,
                      lastTime: snapshot.data![index].timestamp!,
                    );
                  }
                });
          } else {
            return Center(
                child: Container(
                    width: 200,
                    height: 200,
                    child: const CircularProgressIndicator()));
          }
        });
  }
}
