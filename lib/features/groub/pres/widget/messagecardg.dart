import 'package:chatsapp/costants/size.dart';
import 'package:chatsapp/firebase/firedata.dart';
import 'package:chatsapp/models/messagemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../costants/colors.dart';

class Messagecardg extends StatefulWidget {
  const Messagecardg({
    super.key,
    required this.message,
    required this.roomid,
  });
  final Messagemodel message;
  final String roomid;

  @override
  State<Messagecardg> createState() => _MessagecardgState();
}

class _MessagecardgState extends State<Messagecardg> {
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
          color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
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
              isme
                  ? Container()
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .doc(widget.message.formid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.data()!['name'],
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          );
                        }else{
                          return Container();
                        }
                      }),
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
