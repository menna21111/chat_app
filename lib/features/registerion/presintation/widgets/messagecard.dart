import 'package:chatsapp/costants/size.dart';
import 'package:chatsapp/firebase/firedata.dart';
import 'package:chatsapp/models/messagemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../costants/colors.dart';

class Messagecard extends StatefulWidget {
  const Messagecard({super.key, required this.message, required this.roomid, required this.isselectes});
  final Messagemodel message;
  final String roomid;
  final bool isselectes;

  @override
  State<Messagecard> createState() => _MessagecardState();
}

class _MessagecardState extends State<Messagecard> {
  @override
  void initState() {
    if (widget.message.toid == FirebaseAuth.instance.currentUser!.uid) {
      Firedata().readmessage(widget.roomid, widget.message.id!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isme = widget.message.formid == FirebaseAuth.instance.currentUser!.uid;
    screan_size.init(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
          color:widget.isselectes ?kgreycolor: Colors.transparent, borderRadius: BorderRadius.circular(5)),
      child: Align(
        alignment: isme ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: screan_size.width * 0.7),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: isme ? Colors.green : Colors.amber,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10))),
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.message.message ?? '',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      DateFormat.yMMMEd().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(widget.message.createdAt ?? '0'))),
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  isme
                      ? Icon(
                          Icons.done_all,
                          size: 16,
                          color: widget.message.read == ''
                              ? Colors.black
                              : Colors.amber,
                        )
                      : Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
