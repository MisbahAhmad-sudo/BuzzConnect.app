import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class StatusController extends GetxController with WidgetsBindingObserver{

  final db=FirebaseFirestore.instance;
  final auth=FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance?.addObserver(this); // Add ?. for null safety
    print("here is i am");

    // Manually call didChangeAppLifecycleState with the current app lifecycle state
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      didChangeAppLifecycleState(AppLifecycleState.resumed);
    });
  }

  //we write override so that we can override function
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("here is misbah");
    print('AppLifecycleState: $state');
    if(state == AppLifecycleState.resumed){
      await db.collection("users").doc(auth.currentUser!.uid).update({
        "status": "Online",
      });
      print("online");

    }else if(state ==AppLifecycleState.inactive){
      await db.collection("users").doc(auth.currentUser!.uid).update({
        "status": "Offline",
      });
      print("offline");
    }

  }


  @override
  void dispose(){
    print("hello in close mode");
    WidgetsBinding.instance?.removeObserver(this);
    // Manually call didChangeAppLifecycleState with the current app lifecycle state
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      didChangeAppLifecycleState(AppLifecycleState.inactive);
    });
    super.dispose();
  }
}