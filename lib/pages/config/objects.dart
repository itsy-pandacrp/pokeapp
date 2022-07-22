import 'package:flutter/material.dart';

class User {
  final String name;
  final String token;
  final Uri profilePicture;

  User({required this.name, required this.token, required this.profilePicture});

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json["name"],
      token: json["token"],
      profilePicture: json["profilePicture"]);
}

class Chat {
  final int chatId;
  final String chatImage;
  final String userName;
  final String lastMessage;

  Chat(
      {required this.chatId,
      required this.chatImage,
      required this.userName,
      required this.lastMessage});

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        chatId: json["chat_id"],
        chatImage: json["chat_image"],
        userName: json["user_name"],
        lastMessage: json["last_message"],
      );
}

class Feed {
  final String type;
  final String id;
  final String title;
  final String date;
  final String content;
  final String image;

  Feed({
    required this.type,
    required this.id,
    required this.title,
    required this.date,
    required this.content,
    required this.image,
  });

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        type: json["type"],
        id: json["id"],
        title: json["title"],
        date: json["date"],
        content: json["content"],
        image: json["image"],
      );
}
