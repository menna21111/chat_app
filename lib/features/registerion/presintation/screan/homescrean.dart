import 'package:chatsapp/costants/colors.dart';
import 'package:chatsapp/costants/size.dart';
import 'package:chatsapp/features/registerion/presintation/widgets/textfield.dart';
import 'package:chatsapp/firebase/firedata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../models/roommodel.dart';
import '../widgets/homecardperson.dart';

class HomeScrean extends StatelessWidget {
  HomeScrean({super.key,  this.myemail});
  final TextEditingController emailController = TextEditingController();
  final String? myemail;

  @override
  Widget build(BuildContext context) {
    screan_size.init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () async {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                await FirebaseAuth.instance.signOut();
              },
              child: const Icon(
                Icons.login,
                size: 34,
                color: Colors.white,
              ))
        ],
        title: const Text(
          'Chats',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kprimarycolor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('rooms')
              .where('meembers',
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<Roommodel> items = snapshot.data!.docs.map((e) {
                return Roommodel.fromJson(e.data()); //doc is a;ist
              }).toList()
                ..sort(
                    (a, b) => b.lastMessageTime!.compareTo(a.lastMessageTime!));
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Homecardperson(
                      model: items[index],
                    );
                  });
            }
             else if (snapshot.hasError) {
              return const Center(
                child: Text('error'),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('no contacts start to add'),
              );
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
                    bottom: MediaQuery.of(context).viewInsets.bottom,// refers to the area at the bottom of the screen that might be covered by the keyboard. When the keyboard appears, it pushes the screen content up, and viewInsets.bottom provides the height of the visible portion of the keyboard.
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
                                await Firedata()
                                    .createRoom(emailController.text,myemail??'', context);
                                Navigator.pop(context);
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
