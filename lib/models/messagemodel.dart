class Messagemodel {
  String? id;

  String? toid;
  String? formid;
  String? message;
  String? type;
  String createdAt;
  String? read;
  Messagemodel(
      {required this.id,
      required this.toid,
      required this.formid,
      required this.message,
      required this.type,
      required this.read,
      required this.createdAt});
  factory Messagemodel.fromJson(Map<String, dynamic> json) {
    return Messagemodel(
      id: json['id'] ?? '',
      toid: json['to_id'] ,
      formid: json['form_id'] ,
      message: json['message'] ?? '',
      createdAt: json['created_At'] ,
      type: json['type'] ?? '',
      read: json['read'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'to_id': toid,
      'form_id': formid,
      'message': message,
      'created_At': createdAt,
      'type': type,
      'read': read
    };
  }
}
