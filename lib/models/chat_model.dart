import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  static String tableName = "chats";
  final String id;
  final String message;
  final DateTime messageTime;
  final String senderId;
  final DateTime? lastMessageTime;
  final MediaModel? media;
  final String? profileImae;
  ChatModel({
    required this.id,
    this.profileImae,
    required this.message,
    required this.messageTime,
    required this.senderId,
    this.lastMessageTime,
    this.media,
  });

  ChatModel copyWith({
    String? id,
    String? profileImae,
    String? message,
    DateTime? messageTime,
    String? senderId,
    bool? isRead,
    DateTime? lastMessageTime,
    MediaModel? media,
  }) {
    return ChatModel(
        id: id ?? this.id,
        profileImae: profileImae ?? this.profileImae,
        message: message ?? this.message,
        messageTime: messageTime ?? this.messageTime,
        senderId: senderId ?? this.senderId,
        media: media ?? this.media,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'profileImae': profileImae,
      'messageTime': Timestamp.fromDate(messageTime),
      'senderId': senderId,
      'media': media?.toMap(),
      'lastMessageTime': Timestamp.fromDate(lastMessageTime ?? DateTime.now())
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? "",
      message: map['message'] ?? "",
      profileImae: map['profileImae'] ?? "",
      messageTime: (map['messageTime'] as Timestamp).toDate(),
      lastMessageTime: (map['lastMessageTime'] as Timestamp).toDate(),
      senderId: map['senderId'] ?? "",
      media: map['media'] != null ? MediaModel.fromMap(map['media']) : null,
    );
  }

  @override
  String toString() {
    return 'ChatModel( id: $id, message: $message, messageTime: $messageTime, senderId: $senderId, media: $media , profileImae: $profileImae)';
  }
}

class MediaModel {
  final String id;
  final int type;
  final String? thumbnail;
  final String url;
  final DateTime createdAt;
  final String name;
  MediaModel({
    required this.type,
    this.thumbnail,
    required this.id,
    required this.url,
    required this.createdAt,
    required this.name,
  });

  MediaModel copyWith({
    String? id,
    int? type,
    String? thumbnail,
    String? url,
    DateTime? createdAt,
    String? name,
  }) {
    return MediaModel(
      id: id ?? this.id,
      type: type ?? this.type,
      thumbnail: thumbnail ?? this.thumbnail,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'thumbnail': thumbnail,
      'type': type,
      'createdAt': Timestamp.fromDate(createdAt),
      'name': name,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      id: map['id'] as String,
      url: map['url'] as String,
      thumbnail: map['thumbnail'] ?? "",
      type: map['type'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      name: map['name'] as String,
    );
  }

  @override
  String toString() {
    return 'MediaModel(thumbnail: $thumbnail, type: $type, id: $id, url: $url, createdAt: $createdAt, name: $name)';
  }
}
