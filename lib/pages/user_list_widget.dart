import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/controller/chatController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/user_tile.dart';
import '../model/UserModel.dart';
import 'chat_page.dart';

class UserListWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController searchController;
  ChatController chatController = Get.put(ChatController());

  UserListWidget({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('loading..');
        }
        final searchText = searchController.text.toLowerCase();
        final users = snapshot.data!.docs.where((doc) {
          final data = doc.data()! as Map<String, dynamic>;
          final name = data['name'].toLowerCase();
          return name.contains(searchText);
        }).toList();

        return ListView(
          children: users.map<Widget>((doc) => _buildUserListItem(context, doc)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(BuildContext context, DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.email != data['email']) {
      String? imageUrl = data['profileImage']; // Nullable imageUrl

      return UserTile(
        userName: data['name'],
        userEmail: data['email'],
        role: "",
        imageUrl: imageUrl ?? '',
        onTap: () {
          Get.to(ChatPage(
              targetUser: UserModel.fromJson(data)
          ),);
        },
      );
    } else {
      return Container();
    }
  }
}
