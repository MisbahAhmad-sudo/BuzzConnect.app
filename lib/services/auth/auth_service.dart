import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../model/UserModel.dart';

class AuthServices extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late UserModel currentUser; // Define currentUser at class level

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the user's name is already present in the database
      var userDoc = await _fireStore.collection('users').doc(userCredential.user!.uid).get();
      String? name = userDoc.data()?['name'];

      // If name is not present, fetch it from the database
      if (name == null) {
        // Fetch the user details
        var userData = await _fireStore.collection('users').doc(userCredential.user!.uid).get();
        name = userData.data()?['name'];
      }

      // Initialize variables for other fields with default values
      String? profileImage;
      String? phoneNumber;
      String? about;

      // Check if other fields like profileImage, phoneNumber, about are already present in Firestore
      var userData = userDoc.data();
      if (userData != null) {
        profileImage = userData['profileImage'];
        phoneNumber = userData['phoneNumber'];
        about = userData['about'];
      }

      // Update the currentUser with the retrieved data
      currentUser = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
        // Assign profileImage, phoneNumber, about only if they are not null
        profileImage: profileImage,
        phoneNumber: phoneNumber,
        about: about,
      );

      // Save UserModel to Firestore without overwriting existing data
      await _fireStore.collection('users').doc(currentUser.uid!).set(
        currentUser.toJson(),
        SetOptions(merge: true), // Merge options to avoid overwriting existing data
      );

      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "status": "Online",
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(String name, email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      // Create UserModel instance
      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      // Save UserModel to Firestore
      await _fireStore.collection('users').doc(userModel.uid).set(
        userModel.toJson(),
      );
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "status": "Online",
      });

      // Set currentUser
      currentUser = userModel;

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "status": "Offline",
    });
    return await FirebaseAuth.instance.signOut();
  }
}
