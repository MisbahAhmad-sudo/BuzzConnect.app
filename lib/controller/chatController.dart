import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/controller/contactController.dart';
import 'package:final_project/controller/profileController.dart';
import 'package:final_project/model/CallModel.dart';
import 'package:final_project/model/ChatRoomModel.dart';
import 'package:final_project/model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../model/ChatModel.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var uuid = Uuid();
  ProfileController profileController = Get.put(ProfileController());
  RxString selectedImagePath = "".obs;
  RxString selectedVideoPath = "".obs;
  void clearSelectedFile() {
    selectedImagePath.value = "";
    selectedVideoPath.value = "";
  }
  ContactController contactController = Get.put(ContactController());

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.uid!;
    String targetUserId = targetUser.uid!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUser;
    } else {
      return targetUser;
    }
  }

  UserModel getReceiver(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.uid!;
    String targetUserId = targetUser.uid!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return targetUser;
    } else {
      return currentUser;
    }
  }

  Future<void> sendMessage(
      String targetUserId, String message, UserModel targetUser) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);

    UserModel sender =
    getSender(profileController.currentUser.value, targetUser);
    UserModel receiver =
    getReceiver(profileController.currentUser.value, targetUser);
    RxString imageUrl = "".obs;
    RxString videoUrl = "".obs;
    if (selectedImagePath.value.isNotEmpty) {
      imageUrl.value =
      await profileController.uploadFileToFirebase(selectedImagePath.value);
      selectedImagePath.value = "";
    } else if (selectedVideoPath.value.isNotEmpty) {
      videoUrl.value =
      await profileController.uploadFileToFirebase(selectedVideoPath.value);
      print("path form firebase is " + videoUrl.value);
      selectedVideoPath.value = "";
    }

    var newChat = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl.value,
      videoUrl: videoUrl.value,
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName: profileController.currentUser.value.name,
      timestamp: Timestamp.now(),
    );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessageTimestamp: Timestamp.now(),
      sender: sender,
      receiver: receiver,
      timestamp: Timestamp.now(),
      unReadMessNo: 0,
    );

    try {
      await db
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(
        newChat.toJson(),
      );
      selectedImagePath.value = "";
      selectedVideoPath.value = "";
      await db.collection("chats").doc(roomId).set(
        roomDetails.toJson(),
      );
      await contactController.saveContact(targetUser);
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> sendAudioMessage(
      String targetUserId, String audioUrl, UserModel targetUser) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);

    UserModel sender =
    getSender(profileController.currentUser.value, targetUser);
    UserModel receiver =
    getReceiver(profileController.currentUser.value, targetUser);

    var newChat = ChatModel(
      id: chatId,
      message: "",
      imageUrl: "",
      videoUrl: "",
      audioUrl: audioUrl,
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName: profileController.currentUser.value.name,
      timestamp: Timestamp.now(),
    );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: "",
      lastMessageTimestamp: Timestamp.now(),
      sender: sender,
      receiver: receiver,
      timestamp: Timestamp.now(),
      unReadMessNo: 0,
    );

    try {
      await db
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(
        newChat.toJson(),
      );
      await db.collection("chats").doc(roomId).set(
        roomDetails.toJson(),
      );
      await contactController.saveContact(targetUser);
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);
    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => ChatModel.fromJson(doc.data()),
      )
          .toList(),
    );
  }

  //to show status of users
  Stream<UserModel> getStatus(String uid) {
    return db.collection('users').doc(uid).snapshots().map((event) {
      return UserModel.fromJson(event.data()!);
    });
  }

  //get call history
  Stream<List<CallModel>> getCalls() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("calls")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map(
          (doc) => CallModel.fromJson(doc.data()),
    )
        .toList());
  }
}
