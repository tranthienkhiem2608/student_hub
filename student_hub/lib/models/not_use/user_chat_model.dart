class UserChat {
  final int id;
  final String name;
  final String avatar;

  UserChat({
    required this.id,
    required this.name,
    required this.avatar,
  });
}

final UserChat currentUserChat = UserChat(
    id: 0, name: 'You', avatar: 'assets/images/chat_avatar/Addison.jpg');

final UserChat addison = UserChat(
    id: 1, name: 'Addison', avatar: 'assets/images/chat_avatar/Addison.jpg');

final UserChat angel = UserChat(
    id: 2, name: 'Angel', avatar: 'assets/images/chat_avatar/Angel.jpg');

final UserChat deanna = UserChat(
    id: 3, name: 'Deanna', avatar: 'assets/images/chat_avatar/Deanna.jpg');

final UserChat jason = UserChat(
    id: 4, name: 'Json', avatar: 'assets/images/chat_avatar/Jason.jpg');

final UserChat judd =
    UserChat(id: 5, name: 'Judd', avatar: 'assets/images/chat_avatar/Judd.jpg');

final UserChat leslie = UserChat(
    id: 6, name: 'Leslie', avatar: 'assets/images/chat_avatar/Leslie.jpg');

final UserChat nathan = UserChat(
    id: 7, name: 'Nathan', avatar: 'assets/images/chat_avatar/Nathan.jpg');

final UserChat stanley = UserChat(
    id: 8, name: 'Stanley', avatar: 'assets/images/chat_avatar/Stanley.jpg');

final UserChat virgil = UserChat(
    id: 9, name: 'Virgil', avatar: 'assets/images/chat_avatar/Virgil.jpg');
