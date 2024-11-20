class Roommodel {
  String? id;
  List? meembers;
  String myemail;
  String friendemail;
  String? lastMessage;
  String? lastMessageTime;
  String createdAt;
  Roommodel(
      {required this.id,
      required this.meembers,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.createdAt
     , required this.myemail
     , required this.friendemail

      });
  factory Roommodel.fromJson(Map<String, dynamic> json) {
    return Roommodel(
      id: json['id'] ?? '',
      meembers: json['meembers'] ?? [],
      lastMessage: json['last_Message'] ?? '',
      lastMessageTime: json['last_Message_Time'] ?? '',
      createdAt: json['created_At'], friendemail: 'frendemail', myemail: 'myemail',
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meembers': meembers,
      'last_Message': lastMessage,
      'last_Message_Time': lastMessageTime,
      'created_At': createdAt,
      friendemail: 'frendemail', myemail: 'myemail',
    };
  }
}
