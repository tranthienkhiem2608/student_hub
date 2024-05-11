import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/model/message.dart';
import 'package:student_hub/models/model/interview.dart';
import 'package:student_hub/models/model/meetingRoom.dart';

class Notify {
  int? id;
  String? createAt;
  String? updateAt;
  String? deletedAt;
  String? notifyFlag;
  String? typeNotifyFlag;
  String? title;
  User? receiver;
  User? sender;
  Message? message;
  String? content;
  Interview? interview;
  MeetingRoom? meetingRoom;
  Proposal? proposal;

  Notify(
      {this.id,
      this.createAt,
      this.updateAt,
      this.deletedAt,
      this.notifyFlag,
      this.typeNotifyFlag,
      this.title,
      this.receiver,
      this.sender,
      this.message,
      this.content,
      this.interview,
      this.meetingRoom,
      this.proposal});

  Map<String, dynamic> toMapNotify() {
    return {
      'id': id,
      'notifyFlag': notifyFlag,
      'title': title,
      'receiver': receiver!.toMapUser(),
      'sender': sender!.toMapUser(),
      'message': message!.toMapSendMessage(),
      'content': content,
    };
  }

  factory Notify.fromMapNotify(Map<String, dynamic> map) {
    return Notify(
        id: map['id'],
        createAt: map['createdAt'],
        updateAt: map['updatedAt'],
        deletedAt: map['deletedAt'],
        notifyFlag: map['notifyFlag'],
        typeNotifyFlag: map['typeNotifyFlag'],
        title: map['title'],
        content: map['content'],
        receiver: User.fromMapUserNotify(map['receiver']),
        sender: User.fromMapUserNotify(map['sender']),
        message: Message.fromMapNote(map['message']),
        proposal: map['proposal'] == null
            ? null
            : Proposal.fromMapProposalStudent(map['proposal']));
  }

  static List<Notify> fromMapListNotify(List<dynamic> list) {
    List<Notify> notifications = [];
    for (var notification in list) {
      notifications.add(Notify.fromMapNotify(notification));
    }
    return notifications;
  }

  factory Notify.fromMapNoteLastMessage(Map<String, dynamic> map) {
    return Notify(
        id: map['id'], notifyFlag: map['notifyFlag'], meetingRoom: null);
  }
}
