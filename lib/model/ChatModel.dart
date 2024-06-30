import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));
String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    String? id,
    String? message,
    String? senderName,
    String? senderId,
    String? receiverId,
    Timestamp? timestamp, // Change type to Timestamp
    String? readStatus,
    String? imageUrl,
    String? audioUrl,
    String? videoUrl,
    String? documentUrl,
    List<String>? reactions,
    List<dynamic>? replies,
  }) {
    _id = id;
    _message = message;
    _senderName = senderName;
    _senderId = senderId;
    _receiverId = receiverId;
    _timestamp = timestamp; // Assign the provided timestamp directly
    _readStatus = readStatus;
    _imageUrl = imageUrl;
    _audioUrl = audioUrl;
    _videoUrl = videoUrl;
    _documentUrl = documentUrl;
    _reactions = reactions;
    _replies = replies;
  }

  ChatModel.fromJson(dynamic json) {
    _id = json['id'];
    _message = json['message'];
    _senderName = json['senderName'];
    _senderId = json['senderId'];
    _receiverId = json['receiverId'];
    _timestamp = json['timestamp']; // Change to accept Timestamp type
    _readStatus = json['readStatus'];
    _imageUrl = json['imageUrl'];
    _audioUrl = json['audioUrl'];
    _videoUrl= json['videoUrl'];
    _documentUrl = json['documentUrl'];
    _reactions = json['reactions'] != null ? json['reactions'].cast<String>() : [];
    if (json['replies'] != null) {
      _replies = [];
      json['replies'].forEach((v) {
        _replies?.add(ChatModel.fromJson(v));
      });
    }
  }

  String? _id;
  String? _message;
  String? _senderName;
  String? _senderId;
  String? _receiverId;
  Timestamp? _timestamp; // Change type to Timestamp
  String? _readStatus;
  String? _imageUrl;
  String? _audioUrl;
  String? _videoUrl;
  String? _documentUrl;
  List<String>? _reactions;
  List<dynamic>? _replies;

  ChatModel copyWith({
    String? id,
    String? message,
    String? senderName,
    String? senderId,
    String? receiverId,
    Timestamp? timestamp, // Change type to Timestamp
    String? readStatus,
    String? imageUrl,
    String? audioUrl,
    String? videoUrl,
    String? documentUrl,
    List<String>? reactions,
    List<dynamic>? replies,
  }) =>
      ChatModel(
        id: id ?? _id,
        message: message ?? _message,
        senderName: senderName ?? _senderName,
        senderId: senderId ?? _senderId,
        receiverId: receiverId ?? _receiverId,
        timestamp: timestamp ?? _timestamp, // Assign the provided timestamp directly
        readStatus: readStatus ?? _readStatus,
        imageUrl: imageUrl ?? _imageUrl,
        audioUrl: audioUrl ?? _audioUrl,
        videoUrl: videoUrl ?? _videoUrl,
        documentUrl: documentUrl ?? _documentUrl,
        reactions: reactions ?? _reactions,
        replies: replies ?? _replies,
      );

  String? get id => _id;
  String? get message => _message;
  String? get senderName => _senderName;
  String? get senderId => _senderId;
  String? get receiverId => _receiverId;
  Timestamp? get timestamp => _timestamp; // Change type to Timestamp
  String? get readStatus => _readStatus;
  String? get imageUrl => _imageUrl;
  String? get audioUrl => _audioUrl;
  String? get videoUrl => _videoUrl;
  String? get documentUrl => _documentUrl;
  List<String>? get reactions => _reactions;
  List<dynamic>? get replies => _replies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['message'] = _message;
    map['senderName'] = _senderName;
    map['senderId'] = _senderId;
    map['receiverId'] = _receiverId;
    map['timestamp'] = _timestamp; // Change to accept Timestamp type
    map['readStatus'] = _readStatus;
    map['imageUrl'] = _imageUrl;
    map['audioUrl'] = _audioUrl;
    map['videoUrl'] = _videoUrl;
    map['documentUrl'] = _documentUrl;
    map['reactions'] = _reactions;
    if (_replies != null) {
      map['replies'] = _replies?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
