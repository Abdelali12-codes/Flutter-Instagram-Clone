class Usermodel {
  String uid;
  String name;
  String email;
  String username;
  int state;
  // String status;
  // int state;
  String profilePhoto;

  Usermodel({
    this.uid,
    this.name,
    this.email,
    this.username,
    // this.status,
    this.state,
    this.profilePhoto,
  });

  Map toMap(Usermodel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['fullname'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    // data["status"] = user.status;
    // data["state"] = user.state;
    data['state'] = user.state;
    data["photourl"] = user.profilePhoto;
    return data;
  }

  // Named constructor
  Usermodel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['fullname'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.state = mapData['state'];
    // this.status = mapData['status'];
    // this.state = mapData['state'];
    this.profilePhoto = mapData['photourl'];
  }
}
