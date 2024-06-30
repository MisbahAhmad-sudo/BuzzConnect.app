import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());
class UserModel {
  UserModel({
    this.uid,
    this.name,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.about,
    this.createdAt,
    this.lastOnlineStatus,
    this.status,
    this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] as String?;
    name = json['name'] as String?;
    email = json['email'] as String?;
    profileImage = json['profileImage'] as String?;
    phoneNumber = json['phoneNumber'] as String?;
    about = json['about'] as String?;
    createdAt = json['createdAt'] as String?;
    lastOnlineStatus = json['lastOnlineStatus'] as String?;
    status = json['status'] as String?;
    role = json['role'] as String?;
  }

  String? uid;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? about;
  String? createdAt;
  String? lastOnlineStatus;
  String? status;
  String? role;
  UserModel copyWith({  String? uid,
    String? name,
    String? email,
    String? profileImage,
    String? phoneNumber,
    String? about,
    String? createdAt,
    String? lastOnlineStatus,
    String? status,
    String? role,
  }) => UserModel(  uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    profileImage: profileImage ?? this.profileImage,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    about: about ?? this.about,
    createdAt: createdAt ?? this.createdAt,
    lastOnlineStatus: lastOnlineStatus ?? this.lastOnlineStatus,
    status: status ?? this.status,
    role: status ?? this.role,

  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['name'] = name;
    map['email'] = email;
    map['profileImage'] = profileImage;
    map['phoneNumber'] = phoneNumber;
    map['about'] = about;
    map['createdAt'] = createdAt;
    map['lastOnlineStatus'] = lastOnlineStatus;
    map['status'] = status;
    map['role'] = role;

    return map;
  }

}