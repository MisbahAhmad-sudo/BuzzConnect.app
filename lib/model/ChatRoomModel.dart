import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/ChatModel.dart';
import 'package:final_project/model/UserModel.dart';

class ChatRoomModel {
  final String? id;
  final UserModel? sender;
  final UserModel? receiver;
  final List<ChatModel> messages; // List of ChatModel objects

  // Other fields...
  final int? unReadMessNo;
  final String? lastMessage;
  final Timestamp? lastMessageTimestamp;
  final Timestamp? timestamp;

  // Constructor
  ChatRoomModel({
    this.id,
    this.sender,
    this.receiver,
    this.messages = const [], // Initialize messages as an empty list
    this.unReadMessNo,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.timestamp,
  });

  // Factory method to deserialize JSON data
  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'],
      sender: UserModel.fromJson(json['sender']),
      receiver: UserModel.fromJson(json['receiver']),
      messages: List<ChatModel>.from(
          json['messages']?.map((x) => ChatModel.fromJson(x)) ?? []), // Deserialize list of messages
      unReadMessNo: json['unReadMessNo'],
      lastMessage: json['lastMessage'],
      lastMessageTimestamp: json['lastMessageTimestamp'],
      timestamp: json['timestamp'],
    );
  }

  // Method to serialize to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender?.toJson(),
      'receiver': receiver?.toJson(),
      'messages': messages.map((x) => x.toJson()).toList(), // Serialize list of messages
      'unReadMessNo': unReadMessNo,
      'lastMessage': lastMessage,
      'lastMessageTimestamp': lastMessageTimestamp,
      'timestamp': timestamp,
    };
  }
}
