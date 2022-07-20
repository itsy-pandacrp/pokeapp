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
