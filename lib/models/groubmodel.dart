
class Groubmodel {
  String? id;

  String? name;
  String? image;
  String? lastMessage;
  String? lastMessagetime;
 List<String> members;
 List<String> admins;
  String createdAt;
 
  Groubmodel(
      {required this.id,
      required this. name,
      required this.image,
      required this.lastMessage,
      required this.lastMessagetime,
      required this.members,
      required this.admins,

      required this.createdAt});
  factory Groubmodel.fromJson(Map<String, dynamic> json) {
    return Groubmodel(
      id: json['id'] ?? '',
      name: json['name'] ,
      image: json['image'] ,
      admins:   (json['admins'] as List<dynamic>).map((e) => e.toString()).toList(),
      createdAt: json['created_At'] ,
      members:   (json['members'] as List<dynamic>).map((e) => e.toString()).toList() ,
      lastMessage: json['last_Message'] ?? '',
      lastMessagetime: json['last_Message_Time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'admins': admins,
      'members': members,
      'created_At': createdAt,
      'last_Message_Time': lastMessagetime,
      'last_Message': lastMessage
    };
  }
}
