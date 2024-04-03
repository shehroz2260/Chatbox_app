import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String profile;
  final String name;
  final String email;
  final String address;
  final String status;
  final String uid;
  final String phoneNumber;
  final bool isSelect;
  final bool isActive;
  static const String tableName = "users";
  UserModel({
    required this.profile,
    required this.name,
    required this.email,
    this.isSelect = false,
    this.isActive = false,
    required this.address,
    required this.status,
    required this.uid,
    required this.phoneNumber,
  });

  UserModel copyWith({
    String? profile,
    String? name,
    String? email,
    String? address,
    String? status,
    String? uid,
    String? phoneNumber,
    bool? isSelect,
    bool? isActive,
  }) {
    return UserModel(
        profile: profile ?? this.profile,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        status: status ?? this.status,
        isSelect: isSelect ?? this.isSelect,
        isActive: isActive ?? this.isActive);
  }

  static final emptyModel = UserModel(
      profile: "",
      name: "",
      email: "",
      address: "",
      status: "",
      uid: "",
      phoneNumber: "");

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profile': profile,
      'name': name,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'status': status,
      'isActive': isActive,
    };
  }

  void updateorAddUser() async {
    await FirebaseFirestore.instance
        .collection(tableName)
        .doc(uid)
        .set(toMap(), SetOptions(merge: true));
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      profile: map['profile'] ?? "",
      name: map['name'] ?? "",
      uid: map['uid'] ?? "",
      email: map['email'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      address: map['address'] ?? "",
      status: map['status'] ?? "",
      isActive: map['isActive'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserModel(profile: $profile, name: $name, email: $email, address: $address, status: $status, $uid: uid, $phoneNumber: phoneNumber, isActive: $isActive)';
  }
}
