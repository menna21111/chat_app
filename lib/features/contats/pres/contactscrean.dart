import 'package:chatsapp/costants/colors.dart';
import 'package:chatsapp/costants/size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase/firedata.dart';
import '../../../models/usermodel.dart';

import '../../registerion/data/cubit.dart';
import '../../registerion/data/cubit/changes_cubit.dart';
import '../../registerion/presintation/screan/chatscrean.dart';
import '../../registerion/presintation/widgets/textfield.dart';

class Contactscrean extends StatefulWidget {
  Contactscrean({
    super.key,
  });

  @override
  State<Contactscrean> createState() => _ContactscreanState();
}

class _ContactscreanState extends State<Contactscrean> {
  bool thestate = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screan_size.init(context);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimarycolor,
          title: thestate
              ? TextField(
                  onChanged: (value) {
                    setState(() {
                      searchController.text = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  autofocus: true,
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                )
              : const Text(
                  'My Contacts',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
          actions: [
            thestate
                ? IconButton(
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        thestate = false;
                        searchController.text = "";
                      });
                    },
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        thestate = true;
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ))
          ]),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final contact = snapshot.data!.data()!['mycontacts'] as List;

              return contact.isEmpty ? const Center(child: Text('No contacts'),) : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .where('id', whereIn: contact.isEmpty ? [] : contact)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<ChatUser> users = snapshot.data!.docs
                          .map((e) => ChatUser.fromJson(e.data()))
                          .where((e) => e.name!
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .toList()
                        ..sort((a, b) => a.name!.compareTo(b.name!));
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: Text(
                                users[index].name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  List<String> roomid = [
                                    users[index].id!,
                                    FirebaseAuth.instance.currentUser!.uid
                                  ]..sort((a, b) => a.compareTo(b));

                                  Firedata().createRoom(users[index].id ?? '1', FirebaseAuth.instance.currentUser!.email!, context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Chatscrean(
                                        friendid: users[index].id ?? '1',
                                        roomid: roomid.toString(),
                                        friendname: users[index].name ?? 'user',
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.chat,
                                  color: kprimarycolor,
                                  size: 24,
                                ),
                              ),
                            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context)
                        .viewInsets
                        .bottom, // refers to the area at the bottom of the screen that might be covered by the keyboard. When the keyboard appears, it pushes the screen content up, and viewInsets.bottom provides the height of the visible portion of the keyboard.
                    left: 16,
                    right: 16,
                  ),
                  child: SizedBox(
                      width: screan_size.width,
                      height: screan_size.hieght * .3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: screan_size.hieght * .02,
                          ),
                          Container(
                            height: 5,
                            width: screan_size.width * .15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kgreycolor),
                          ),
                          SizedBox(
                            height: screan_size.hieght * .04,
                          ),
                          Customtextfield(
                              hinttext: 'enter friend email',
                              controller: emailController,
                              icon: Icons.email),
                          SizedBox(
                            height: screan_size.hieght * .045,
                          ),
                          SizedBox(
                            height: screan_size.hieght * .07,
                            width: screan_size.width * .8,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: kprimarycolor,
                              ),
                              onPressed: () async {
                                if (emailController.text.isNotEmpty) {
                                  await Firedata().adduser(
                                      emailController.text,
                                      FirebaseAuth.instance.currentUser!.uid,
                                      context);

                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Add Friend',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )),
                );
              });
        },
        backgroundColor: kprimarycolor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
