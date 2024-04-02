class UserModel {
  final String profile;
  final String name;
  final String email;
  final String address;
  final String qoute;
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
    required this.qoute,
    required this.uid,
    required this.phoneNumber,
  });

  UserModel copyWith({
    String? profile,
    String? name,
    String? email,
    String? address,
    String? qoute,
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
        qoute: qoute ?? this.qoute,
        isSelect: isSelect ?? this.isSelect,
        isActive: isActive ?? this.isActive);
  }

  static final emptyModel = UserModel(
      profile: "",
      name: "",
      email: "",
      address: "",
      qoute: "",
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
      'qoute': qoute,
      'isActive': isActive,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      profile: map['profile'] ?? "",
      name: map['name'] ?? "",
      uid: map['uid'] ?? "",
      email: map['email'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      address: map['address'] ?? "",
      qoute: map['qoute'] ?? "",
      isActive: map['isActive'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserModel(profile: $profile, name: $name, email: $email, address: $address, qoute: $qoute, $uid: uid, $phoneNumber: phoneNumber, isActive: $isActive)';
  }
}
