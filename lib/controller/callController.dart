import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/UserModel.dart';
import 'package:final_project/model/CallModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../pages/callPage/audioCallPage.dart';
import '../pages/callPage/videoCallPage.dart';

class CallController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid().v4();

  void onInit() {
    super.onInit();
    getCallsNotification().listen((List<CallModel> callList) {
      if (callList.isNotEmpty) {
        var callData = callList[0];
        if(callData.type == "audio")
          {
            audioCallNotification(callData);
          }
        else if(callData.type == "video")
          {
            videoCallNotification(callData);
          }

      }
    });
  }

  Future<void> audioCallNotification( CallModel callData) async{
    Get.snackbar(
      duration: Duration(days: 1),
      barBlur: 0,
      backgroundColor: Colors.grey[900]!,
      isDismissible: false,
      icon: Icon(Icons.call),
      onTap: (snack) {
        Get.back();
        Get.to(
          AudioCallPage(
            target: UserModel(
              uid: callData.callerUid,
              name: callData.callerName,
              email: callData.callerEmail,
              profileImage: callData.callerPic,
            ),
          ),
        );
      },
      callData.callerName!,
      "Incoming Audio Call",
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: const Text("End Call"),
      ),
    );

  }

  Future<void> callAction(UserModel receiver, UserModel caller, String type) async {
    String id = uuid;
    var newCall = CallModel(
      id: id,
      callerName: caller.name,
      callerEmail: caller.email,
      callerPic: caller.profileImage,
      callerUid: caller.uid,
      receiverName: receiver.name,
      receiverEmail: receiver.email,
      receiverPic: receiver.profileImage,
      receiverUid: receiver.uid,
      status: "dialing",
      type: type,
      timestamp: Timestamp.now(),
      time:DateTime.now().toString(),
    );

    try {
      //for sending notification to receiver we store
      await db
          .collection("notification")
          .doc(receiver.uid)
          .collection("call")
          .doc(id)
          .set(newCall.toJson());
      //for making call history we also store it in users collection
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      //for making call history we also store it in receiver collection
      await db
          .collection("users")
          .doc(receiver.uid)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      Future.delayed(const Duration(seconds: 40), (){endCall(newCall);});
    } catch (e) {
      print(e);
    }
  }

  //get call details
  Stream<List<CallModel>> getCallsNotification() {
    if(auth.currentUser != null) {
      return FirebaseFirestore.instance
          .collection("notification")
          .doc(auth.currentUser!.uid)
          .collection("call")
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => CallModel.fromJson(doc.data()))
              .toList());
    }
    else {
      // Return an empty stream if auth.currentUser is null
      return const Stream.empty();
    }
  }
// after sending notification we delete it

  Future<void> endCall(CallModel call) async{
    try{
      await db
          .collection("notification")
          .doc(call.receiverUid)
          .collection("call")
          .doc(call.id).delete();
    }catch(e){
      print(e);
    }
  }

  void videoCallNotification(CallModel callData) async {

    Get.snackbar(
      duration: Duration(days: 1),
      barBlur: 0,
      backgroundColor: Colors.grey[900]!,
      isDismissible: false,
      icon: Icon(Icons.video_call),
      onTap: (snack) {
        Get.back();
        Get.to(
          VideoCallPage(
            target: UserModel(
              uid: callData.callerUid,
              name: callData.callerName,
              email: callData.callerEmail,
              profileImage: callData.callerPic,
            ),
          ),
        );
      },
      callData.callerName!,
      "Incoming Video Call",
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: Text("End Call"),
      ),
    );
  }



}











