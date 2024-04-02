import 'dart:convert';

class Message {
  String messageID;
  String chatID;
  Role role;
  StringBuffer message;
  List<String> imageUrl;
  DateTime timeSent;

  //constructor
  Message({
    required this.messageID,
    required this.chatID,
    required this.role,
    required this.message,
    required this.imageUrl,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageID': messageID,
      'chatID': chatID,
      'role': role.index,
      'message': message.toString(),
      'imageUrl': imageUrl,
      'timeSent': timeSent.toIso8601String(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageID: map['messageID'] as String,
      chatID: map['chatID'] as String,
      role: Role.values[map['role']],
      message: StringBuffer(map['message']),
      imageUrl: List<String>.from(map['imageUrl']),
      timeSent: DateTime.parse(map['timeSent']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  Message copyWith({
    String? messageID,
    String? chatID,
    Role? role,
    StringBuffer? message,
    List<String>? imageUrl,
    DateTime? timeSent,
  }) {
    return Message(
      messageID: messageID ?? this.messageID,
      chatID: chatID ?? this.chatID,
      role: role ?? this.role,
      message: message ?? this.message,
      imageUrl: imageUrl ?? this.imageUrl,
      timeSent: timeSent ?? this.timeSent,
    );
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.messageID == messageID;
  }

  @override
  int get hashCode {
    return messageID.hashCode;
  }
}

enum Role {
  user,
  assistant,
}
