 class ChatUser {
  String? id;
  String? name;
  String? email;
  String? about;
  String? imageUrl;
  String? status;
  String? statusMessage;
  String? fcmToken;
  String createdAt;
  String? lastActiveAt;
  List? mycontacts ;

  ChatUser({
    this.id,
    this.name,
    this.email,
    this.about,
    this.imageUrl,
    this.status,
    this.statusMessage,
    this.fcmToken,
  required  this.createdAt,
  required  this.mycontacts,
    this.lastActiveAt,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        about: json['about'],
        imageUrl: json['imageUrl'],
        status: json['status'],
        statusMessage: json['statusMessage'],
        fcmToken: json['fcmToken'],
        createdAt: json['createdAt'],
        lastActiveAt: json['lastActiveAt'],mycontacts: json['mycontacts']);

  }
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name':name,
      'email':email,
      'about':about,
      'imageUrl':imageUrl,
      'createdAt':createdAt,
      'lastActiveAt':lastActiveAt,
      'fcmToken':fcmToken,
      'statusMessage':statusMessage,
      'status':status,
      'mycontacts':mycontacts
    };
  }
}
