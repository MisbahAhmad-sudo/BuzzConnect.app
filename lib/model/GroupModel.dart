import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/UserModel.dart';
/// id : ""
/// name : ""
/// description : ""
/// profileUrl : ""
/// members : []
/// createdAt : ""
/// createdBy : ""
/// status : ""
/// lastMessage : ""
/// lastMessageBy : ""
/// lastMessageTime : ""
/// unReadCount : 0
/// timeStamp : ""

GroupModel groupModelFromJson(String str) => GroupModel.fromJson(json.decode(str));
String groupModelToJson(GroupModel data) => json.encode(data.toJson());
class GroupModel {
  GroupModel({
      String? id, 
      String? name, 
      String? description, 
      String? profileUrl, 
      List<UserModel>? members,
    Timestamp? createdAt,
      String? createdBy,
      String? status, 
      String? lastMessage, 
      String? lastMessageBy, 
      String? lastMessageTime, 
      num? unReadCount, 
      Timestamp? timeStamp,}){
    _id = id;
    _name = name;
    _description = description;
    _profileUrl = profileUrl;
    _members = members;
    _createdAt = createdAt;
    _createdBy = createdBy;
    _status = status;
    _lastMessage = lastMessage;
    _lastMessageBy = lastMessageBy;
    _lastMessageTime = lastMessageTime;
    _unReadCount = unReadCount;
    _timeStamp = timeStamp;
}

  GroupModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _profileUrl = json['profileUrl'];
    if (json['members'] != null) {
      _members = [];
      json['members'].forEach((memberJson) {
        _members?.add(UserModel.fromJson(memberJson)); // Mapping each member to UserModel
      });
    }
    _createdAt = json['createdAt'];
    _createdBy = json['createdBy'];
    _status = json['status'];
    _lastMessage = json['lastMessage'];
    _lastMessageBy = json['lastMessageBy'];
    _lastMessageTime = json['lastMessageTime'];
    _unReadCount = json['unReadCount'];
    _timeStamp = json['timeStamp'];
  }

  String? _id;
  String? _name;
  String? _description;
  String? _profileUrl;
  List<UserModel>? _members;
  Timestamp? _createdAt;
  String? _createdBy;
  String? _status;
  String? _lastMessage;
  String? _lastMessageBy;
  String? _lastMessageTime;
  num? _unReadCount;
  Timestamp? _timeStamp;
GroupModel copyWith({  String? id,
  String? name,
  String? description,
  String? profileUrl,
  List<UserModel>? members,
  Timestamp? createdAt,
  String? createdBy,
  String? status,
  String? lastMessage,
  String? lastMessageBy,
  String? lastMessageTime,
  num? unReadCount,
  Timestamp? timeStamp,
}) => GroupModel(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  profileUrl: profileUrl ?? _profileUrl,
  members: members ?? _members,
  createdAt: createdAt ?? _createdAt,
  createdBy: createdBy ?? _createdBy,
  status: status ?? _status,
  lastMessage: lastMessage ?? _lastMessage,
  lastMessageBy: lastMessageBy ?? _lastMessageBy,
  lastMessageTime: lastMessageTime ?? _lastMessageTime,
  unReadCount: unReadCount ?? _unReadCount,
  timeStamp: timeStamp ?? _timeStamp,
);
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get profileUrl => _profileUrl;
  List<UserModel>? get members => _members;
  Timestamp? get createdAt => _createdAt;
  String? get createdBy => _createdBy;
  String? get status => _status;
  String? get lastMessage => _lastMessage;
  String? get lastMessageBy => _lastMessageBy;
  String? get lastMessageTime => _lastMessageTime;
  num? get unReadCount => _unReadCount;
  Timestamp? get timeStamp => _timeStamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['profileUrl'] = _profileUrl;
    if (_members != null) {
      map['members'] = _members?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['createdBy'] = _createdBy;
    map['status'] = _status;
    map['lastMessage'] = _lastMessage;
    map['lastMessageBy'] = _lastMessageBy;
    map['lastMessageTime'] = _lastMessageTime;
    map['unReadCount'] = _unReadCount;
    map['timeStamp'] = _timeStamp;
    return map;
  }

}