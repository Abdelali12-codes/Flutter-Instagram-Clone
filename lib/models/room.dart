class Room {
  String id;
  String receiverId;

  Room({this.id, this.receiverId});

  Room.fromMap(Map<String, dynamic> json) {
    this.id = json['id'];
    this.receiverId = json['with'];
  }

  Map toMap(Room room) {
    Map<String, dynamic> data;

    data['id'] = room.id;
    data['with'] = room.receiverId;

    return data;
  }
}
