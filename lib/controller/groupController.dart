import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/controller/profileController.dart';
import 'package:final_project/model/GroupModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../model/ChatModel.dart';
import '../model/UserModel.dart';

class GroupController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxList<UserModel> groupMembers = <UserModel>[].obs;
  RxString selectedImagePath = "".obs;
  var uuid = Uuid();
  RxBool isLoading = false.obs;
  ProfileController profileController = Get.put(ProfileController());
  RxList<GroupModel> groupList = <GroupModel>[].obs;

  ///////////////////////////////
  @override
  void onInit() {
    super.onInit();
    getGroups();
  }

  //////////////////////////

  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }

  ///////////////////////////////////////
  //create groups
  Future<bool> CreateGroup(String groupName, String imagePath) async {
    isLoading.value = true;
    String groupId = uuid.v6();

    //add admin who is creating group
    groupMembers.add(UserModel(
      uid:auth.currentUser!.uid,
      name: profileController.currentUser.value.name,
      profileImage: profileController.currentUser.value.profileImage,
      email: auth.currentUser!.email,
      role: "admin",
      about: profileController.currentUser.value.about,
      phoneNumber: profileController.currentUser.value.phoneNumber,
    ));

    try {
      String imageUrl = await profileController.uploadFileToFirebase(imagePath);

      await db.collection("groups").doc(groupId).set({
        "id": groupId,
        "name": groupName,
        "profileUrl": imageUrl,
        "members": groupMembers.map((e) => e.toJson()).toList(),
        "createdAt": Timestamp.now(),
        "timeStamp": Timestamp.now(),
        "createdBy": auth.currentUser!.uid,
      });
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

////////////////////////////////////////////
  // dispaly groups
  Future<void> getGroups() async {
    isLoading.value = true;
    List<GroupModel> tempGroup = [];
    await db.collection("groups").get().then((value) {
      tempGroup = value.docs
          .map(
            (e) => GroupModel.fromJson(e.data()),
          )
          .toList();
    });
    groupList.clear();
    groupList.value = tempGroup
        .where((e) =>
            e.members!.any((element) => element.uid == auth.currentUser!.uid))
        .toList();
    isLoading.value = false;
  }

  // send messages in group
  Future<void> sendGroupMessage(
      String message, String groupId ) async {
    isLoading.value=true;
    var chatId = uuid.v6();
    RxString imageUrl = "".obs;
    if(selectedImagePath.value.isNotEmpty){
      imageUrl.value = await profileController.uploadFileToFirebase(selectedImagePath.value);
    };
    var newChat = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl.value,
      senderId: auth.currentUser!.uid,
      senderName: profileController.currentUser.value.name,
      timestamp: Timestamp.now(),
    );

  try{
    await db
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .doc(chatId)
        .set(newChat.toJson());
    selectedImagePath.value="";
    isLoading.value= false;
  }catch(e){
    print(e);
  }
  }

  //receive messages in groups
  Stream<List<ChatModel>> getGroupMessage(String groupId) {
    return db
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList());
  }

  //add member in  already created/existing group
  Future<void> addMemberToGroup(String groupId, UserModel user) async{
    isLoading.value = true;
    await db.collection("groups").doc(groupId).update({
      "members":FieldValue.arrayUnion([user.toJson()])
    },
    );
    getGroups();
    isLoading.value= false;
  }

}
