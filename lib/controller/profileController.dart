import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final store = FirebaseStorage.instance;
  RxBool isLoading = false.obs;
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

  Future<void> updateProfile(
      String imageUrl, String name, String about, String number) async {
    isLoading.value = true;
    //get path of image in database
    final imageLink = await uploadFileToFirebase(imageUrl);
    print(imageLink);
    // Get the current user details
    final currentUserDoc = await db.collection("users").doc(auth.currentUser!.uid).get();
    final currentUserData = currentUserDoc.data();
    if (currentUserData != null) {
      //update user profile in firestore
      try {
        final updatedUser = UserModel(
          name: name,
          about: about,
          profileImage: imageUrl == ""?currentUser.value.profileImage:imageLink,
          phoneNumber: number,
          email: currentUserData["email"],
          uid: currentUserData["uid"],
        );
        await db.collection("users").doc(auth.currentUser!.uid).set(
          updatedUser.toJson(),
        );
      } catch (ex) {
        print(ex);
      }
    } else {
      print("Current user data is null");
    }
    isLoading.value = false;
  }

  Future<String> uploadFileToFirebase(String imagePath) async {
    final path = "files/${imagePath}";
    final file = File(imagePath);
    if (imagePath != "") {
      try {
        //store file in database
        final ref = store.ref().child(path).putFile(file);
        final uploadTask = await ref.whenComplete(() {});
        //get Url/path of upload file in database
        final downloadImageUrl = await uploadTask.ref.getDownloadURL();
        print(downloadImageUrl);
        return downloadImageUrl;
      } catch (ex) {
        print(ex);
        return "error";
      }
    }
    return "";
  }
}