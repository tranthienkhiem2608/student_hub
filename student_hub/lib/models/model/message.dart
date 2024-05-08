import 'package:student_hub/models/model/meetingRoom.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/model/interview.dart';

class Message {
  int? id;
  String? createAt;
  int? projectId;
  User? sender;
  User? receiver;
  String? content;
  int? messageFlag;
  ProjectCompany? project;
  int? messageId;
  bool? checkRead = false;
  Interview? interview;
  MeetingRoom? meetingRoom;

  Message({
    this.id,
    this.createAt,
    this.projectId,
    this.sender,
    this.receiver,
    this.content,
    this.messageFlag,
    this.project,
    this.messageId,
    this.checkRead,
    this.interview,
    this.meetingRoom,
  });

  Map<String, dynamic> toMapSendMessage() {
    return {
      'projectId': projectId,
      'content': content,
      'messageFlag': messageFlag,
      'senderId': sender!.id,
      'receiverId': receiver!.id,
    };
  }

  factory Message.fromMapMessage(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      createAt: map['createdAt'],
      content: map['content'],
      sender: User.fromMapUserChat(map['sender']),
      receiver: User.fromMapUserChat(map['receiver']),
      interview: map['interview'] == null
          ? null
          : Interview.fromMapInterview(map['interview']),
      project: map['project'] == null
          ? null
          : ProjectCompany.fromMapAllProject(map['project']),
    );
  }

  static List<Message> formListMapMessage(List<dynamic> list) {
    List<Message> messages = [];
    for (var message in list) {
      messages.add(Message.fromMapMessage(message));
    }
    return messages;
  }

  factory Message.fromNewMessage(Map<String, dynamic> map) {
    return Message(
      id: map['notification']['message']['id'],
      content: map['notification']['message']['content'],
      sender: User.fromMapUserChat(map['notification']['sender']),
      receiver: User.fromMapUserChat(map['notification']['receiver']),
      projectId: map['notification']['message']['projectId'],
      createAt: map['notification']['message']['createdAt'],
      messageFlag: map['messageFlag'],
      messageId: map['notification']['messageId'],
      interview: map['notification']['message']['interview'] == null
          ? null
          : Interview.fromMapInterview(
              map['notification']['message']['interview']),
      meetingRoom: map['notification']['message']['interview'] == null
          ? null
          : MeetingRoom.fromMapMeetingRoom(
              map['notification']['message']['interview']['meetingRoom']),
    );
  }

  factory Message.fromMapLastMessage(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      createAt: map['createdAt'],
      content: map['content'],
      sender: User.fromMapUserChat(map['sender']),
      receiver: User.fromMapUserChat(map['receiver']),
      interview: map['interview'] == null
          ? null
          : Interview.fromMapInterview(map['interview']),
      project: map['project'] == null
          ? null
          : ProjectCompany.fromMapAllProject(map['project']),
    );
  }

  static List<Message> formListMapLastMessage(List<dynamic> list) {
    List<Message> messages = [];
    for (var message in list) {
      messages.add(Message.fromMapLastMessage(message));
    }
    return messages;
  }
}
