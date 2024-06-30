import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

CallModel audioCallFromJson(String str) => CallModel.fromJson(json.decode(str));
String audioCallToJson(CallModel data) => json.encode(data.toJson());

class CallModel {
  CallModel({
    this.id,
    this.callerName,
    this.callerPic,
    this.callerUid,
    this.callerEmail,
    this.receiverEmail,
    this.receiverName,
    this.receiverPic,
    this.receiverUid,
    this.status,
    this.type,
    this.time,
    this.timestamp,
  });

  final String? id;
  final String? callerName;
  final String? callerPic;
  final String? callerUid;
  final String? callerEmail;
  final String? receiverEmail;
  final String? receiverName;
  final String? receiverPic;
  final String? receiverUid;
  final String? status;
  final String? type;
  final String? time;
  final Timestamp? timestamp;

  factory CallModel.fromJson(Map<String, dynamic> json) => CallModel(
    id: json['id'],
    callerName: json['callerName'],
    callerPic: json['callerPic'],
    callerUid: json['callerUid'],
    callerEmail: json['callerEmail'],
    receiverEmail: json['receiverEmail'],
    receiverName: json['receiverName'],
    receiverPic: json['receiverPic'],
    receiverUid: json['receiverUid'],
    status: json['status'],
    type: json['type'],
    time: json['time'],
    timestamp: json['timestamp'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'callerName': callerName,
    'callerPic': callerPic,
    'callerUid': callerUid,
    'callerEmail': callerEmail,
    'receiverEmail': receiverEmail,
    'receiverName': receiverName,
    'receiverPic': receiverPic,
    'receiverUid': receiverUid,
    'status': status,
    'type': type,
    'time': time,
    'timestamp': timestamp,
  };
}
