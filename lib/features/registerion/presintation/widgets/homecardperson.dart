import 'dart:developer';

import 'package:chatsapp/models/messagemodel.dart';
import 'package:chatsapp/models/roommodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../costants/colors.dart';
import '../../../../models/usermodel.dart';
import '../../../../provider/providerapp.dart';
import '../screan/chatscrean.dart';

class Homecardperson extends StatelessWidget {
  final Roommodel model;
  const Homecardperson({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
      final  Prov=Provider.of<Providerapp>(context); 
      bool isdark=Prov.theme==ThemeMode.dark;
    List members= model.meembers!
        .where((element) => element != FirebaseAuth.instance.currentUser!.uid)
        .toList();

    String idd = members.isEmpty ? FirebaseAuth.instance.currentUser!.uid : members.first;
    print(idd);
    log(idd);
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('user').doc(idd).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ChatUser models = ChatUser.fromJson(snapshot.data!.data()!);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => Chatscrean(
                      friendid: idd,
                      roomid: model.id ?? '1',
                      friendname: models.name ?? 'user',
                    ), transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0); // Start off-screen to the right
                    const end = Offset.zero;       // End at the current position
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  ),
                );
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: Colors.grey.shade300))),
                  child: ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.amber,
                      ),
                      title: Text(
                        models.name == '' ? 'me' : models.name ?? 'mmmmmm',
                        style:  TextStyle(
                            color:isdark?Colors.white: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        model.lastMessage == ''
                            ? models.statusMessage ?? 'hi iam use whatsapp'
                            : model.lastMessage!,
                        maxLines: 1,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: kgreycolor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900),
                      ),
                      trailing: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('rooms')
                              .doc(model.id ?? '1')
                              .collection('messages')
                              .snapshots(),
                          builder: (context, snapshot) {
                            final unreadmessages = snapshot.data?.docs
                                .map((e) => Messagemodel.fromJson(e.data()))
                                .where((e) => e.read == '')
                                .where((e) =>
                                    e.toid ==
                                    FirebaseAuth.instance.currentUser!.uid)
                                .toList();
                            return unreadmessages?.length == 0
                                ? Text(DateFormat.yMMMEd().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(
                                            model.lastMessageTime ?? '0'))))
                                : Badge(
                                    backgroundColor: kprimarycolor,
                                    largeSize: 50,
                                    label: Text('${unreadmessages?.length}'),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                  );
                          }))),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
