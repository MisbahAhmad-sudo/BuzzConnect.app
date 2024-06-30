import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    final doc = await db.collection("users").doc(auth.currentUser!.uid).get();
    if (doc.exists) {
      currentUser.value = UserModel.fromJson(doc.data()!);
    }
  }
}
