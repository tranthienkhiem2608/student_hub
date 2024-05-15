class MeetingRoom {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? meeting_room_code;
  String? meeting_room_id;
  String? expired_at;

  MeetingRoom({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.meeting_room_code,
    this.meeting_room_id,
    this.expired_at,
  });

  Map<String, dynamic> toMapMeetingRoom() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'meeting_room_code': meeting_room_code,
      'meeting_room_id': meeting_room_id,
      'expired_at': expired_at,
    };
  }

  factory MeetingRoom.fromMapMeetingRoom(Map<String, dynamic> map) {
    return MeetingRoom(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      meeting_room_code: map['meeting_room_code'],
      meeting_room_id: map['meeting_room_id'],
      expired_at: map['expired_at'],
    );
  }
}
