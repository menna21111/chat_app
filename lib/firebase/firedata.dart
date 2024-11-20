import 'package:chatsapp/models/messagemodel.dart';
import 'package:chatsapp/models/roommodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/groubmodel.dart';

class Firedata {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth fireauth = FirebaseAuth.instance;
  final String myid = FirebaseAuth.instance.currentUser!.uid;
  String now = DateTime.now().millisecondsSinceEpoch.toString();
  Future createRoom(
      String friendemail, String myemail, BuildContext context) async {
    QuerySnapshot frienddoc = await firestore.collection('user').where('email',
        whereIn: [
          friendemail,
          myemail
        ]).get(); // frienddoc is list of doc all back of querysnapshot

    if (frienddoc.docs.isNotEmpty) {
      String friendid = frienddoc.docs.first.id;
      List<String> members = [myid, friendid]..sort((a, b) => a.compareTo(b));
      QuerySnapshot roomexisit = await firestore
          .collection('rooms')
          .where('meembers', isEqualTo: members)
          .get();
      if (roomexisit.docs.isEmpty) {
        Roommodel room = Roommodel(
          friendemail: friendemail,
          myemail: myemail,
          id: members.toString(),
          meembers: members,
          lastMessage: '',
          lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        );
        firestore
            .collection('rooms')
            .doc(members.toString())
            .set(room.toJson());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('thiss email already exists  create')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No user found with that email address')));
    }
  }

  Future adduser(
      String friendemail, String myemail, BuildContext context) async {
    QuerySnapshot frienddoc = await firestore
        .collection('user')
        .where('email', isEqualTo: friendemail)
        .get();

    if (frienddoc.docs.isNotEmpty) {
      String friendid = frienddoc.docs.first.id;

      DocumentSnapshot contacexits =
          await firestore.collection('user').doc(myid).get();
      List contacts = contacexits.get('mycontacts') ?? [];
      if (contacts.contains(friendid)) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('that email already exists adduser')));
      } else {
        firestore.collection('user').doc(myid).update({
          'mycontacts': FieldValue.arrayUnion([friendid])
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found with that email rr')));
    }
  }

  Future sendmessage(String roomid, String message, String toid) async {
    String messagid = Uuid().v1();
    Messagemodel messagemodel = Messagemodel(
      id: messagid,
      toid: toid,
      formid: myid,
      message: message,
      type: 'text',
      read: '',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    await firestore
        .collection('rooms')
        .doc(roomid)
        .collection('messages')
        .doc(messagid)
        .set(messagemodel.toJson());
  await  firestore.collection('rooms').doc(roomid).update({
      'last_Message': message,
      'last_Message_Time': DateTime.now().millisecondsSinceEpoch.toString()
    });
  }
  Future sendGmessage(String groubid, String message, ) async {
    String messagid = Uuid().v1();
    Messagemodel messagemodel = Messagemodel(
      id: messagid,
      toid: '',
      formid: myid,
      message: message,
      type: 'text',
      read: '',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    await firestore
        .collection('groubs')
        .doc(groubid)
        .collection('messages')
        .doc(messagid)
        .set(messagemodel.toJson());
 await   firestore.collection('groubs').doc(groubid).update({
      'last_Message': message,
      'last_Message_Time': DateTime.now().millisecondsSinceEpoch.toString()
    });
  }

  Future readmessage(String roomid, String messagid) async {
    await firestore
        .collection('rooms')
        .doc(roomid)
        .collection('messages')
        .doc(messagid)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }


  Future createGroub(List<String> members, String name) async {
    String id = Uuid().v1();
    members.add(myid);
    Groubmodel groubmofdel = Groubmodel(
        id: id,
        name: name,
        image: '',
        lastMessage: '',
        lastMessagetime: now,
        members: members,
        admins: [myid],
        createdAt: now);
    await firestore.collection('groubs').doc(id).set(groubmofdel.toJson());
  }

  Future deletemeaasage(String roomid, List<String> messags) async {
    if (messags.isNotEmpty) {
      for (var element in List.from(messags)) {
        await firestore
            .collection('rooms')
            .doc(roomid)
            .collection('messages')
            .doc(element)
            .delete();
      }
    }
  }
}
