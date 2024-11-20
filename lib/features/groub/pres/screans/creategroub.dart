import 'dart:developer';

import 'package:chatsapp/firebase/firedata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../costants/colors.dart';
import '../../../../models/usermodel.dart';

class CreateGroupPage extends StatefulWidget {
  CreateGroupPage({Key? key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  TextEditingController groupNameController = TextEditingController();

  List<String> members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: members.isEmpty
          ? Container()
          : FloatingActionButton(
              backgroundColor: kprimarycolor,
              onPressed: () async {
                await Firedata()
                    .createGroub(members, groupNameController.text)
                    .then((value) {
                      print('group created');
                      log('group created');
                   Navigator.of(context).pop();
                });
              },
              child: const Icon(
                Icons.done,
                color: Colors.white,
              ),
            ),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.white)),
            SizedBox(
              width: 20,
            ),
            Text(
              'create group',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: kprimarycolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person,
                          size: 40, color: Colors.white),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: kprimarycolor,
                        child: Icon(Icons.camera_alt,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: groupNameController,
                decoration: InputDecoration(
                  focusColor: kprimarycolor,
                  prefixIcon: const Icon(Icons.group),
                  hintText: 'Group Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Members',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final contact =
                          snapshot.data!.data()!['mycontacts'] as List;

                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('user')
                              .where('id',
                                  whereIn: contact.isEmpty ? [] : contact)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final List<ChatUser> users = snapshot.data!.docs
                                  .map((e) => ChatUser.fromJson(e.data()))
                                  .where((e) =>
                                      e.id !=
                                      FirebaseAuth.instance.currentUser!.uid)
                                  .toList()
                                ..sort((a, b) => a.name!.compareTo(b.name!));
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    activeColor: kprimarycolor,
                                    checkboxShape: CircleBorder(
                                        side: BorderSide(color: kprimarycolor)),
                                    title: Text(users[index].name!),
                                    value: members.contains(users[index].id),
                                    onChanged: (value) {
                                      print(value);
                                      log('gg');
                                      setState(() {
                                        if (value!) {
                                          members.add(users[index].id!);
                                        } else {
                                          members.remove(users[index].id!);
                                        }
                                      });
                                    },
                                  );
                                },
                                itemCount: users.length,
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text('erorr'),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
