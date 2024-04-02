import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/model/interview.dart';

class Message{
  int id;
  User sender;
  User receiver;
  String messageFlag;
  String content;
  Interview interviewId;
  ProjectCompany projectId;

  Message({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.messageFlag,
    required this.content,
    required this.interviewId,
    required this.projectId,
  });

  Map<String, dynamic> toMapMessage() {
    return {
      'id': id,
      'sender': sender.toMapUser(),
      'receiver': receiver.toMapUser(),
      'messageFlag': messageFlag,
      'content': content,
      'interviewId': interviewId.toMapInterview(),
      'projectId': projectId.toMapProjectCompany(),
    };
  }

  factory Message.fromMapMessage(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      sender: User.fromMapUser(map['sender']),
      receiver: User.fromMapUser(map['receiver']),
      messageFlag: map['messageFlag'],
      content: map['content'],
      interviewId: Interview.fromMapInterview(map['interviewId']),
      projectId: ProjectCompany.fromMapProjectCompany(map['projectId']),
    );
  }
}