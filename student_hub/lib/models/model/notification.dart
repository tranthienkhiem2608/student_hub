import 'package:student_hub/models/user.dart';
import 'package:student_hub/models/model/message.dart';

class Notification {
  String id;
  int notifyFlag;
  String title;
  User receiverId;
  User senderId;
  Message messageId;
  String content;

  Notification({
    required this.id,
    required this.notifyFlag,
    required this.title,
    required this.receiverId,
    required this.senderId,
    required this.messageId,
    required this.content,
  });

  Map<String, dynamic> toMapNotification() {
    return {
      'id': id,
      'notifyFlag': notifyFlag,
      'title': title,
      'receiverId': receiverId.toMapUser(),
      'senderId': senderId.toMapUser(),
      'messageId': messageId.toMapMessage(),
      'content': content,
    };
  }

  factory Notification.fromMapNotification(Map<String, dynamic> map) {
    return Notification(
      id: map['id'],
      notifyFlag: map['notifyFlag'],
      title: map['title'],
      receiverId: User.fromMapUser(map['receiverId']),
      senderId: User.fromMapUser(map['senderId']),
      messageId: Message.fromMapMessage(map['messageId']),
      content: map['content'],
    );
  }


}