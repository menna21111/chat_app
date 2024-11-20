import 'package:chatsapp/costants/colors.dart';
import 'package:chatsapp/costants/size.dart';
import 'package:chatsapp/features/groub/pres/screans/creategroub.dart';
import 'package:chatsapp/models/groubmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../firebase/firedata.dart';
import '../../../../models/usermodel.dart';
import '../../../registerion/presintation/screan/chatscrean.dart';
import '../../../registerion/presintation/widgets/textfield.dart';
import 'chatgscrean.dart';

class Groubsscrean extends StatefulWidget {
  const Groubsscrean({
    super.key,
  });

  @override
  State<Groubsscrean> createState() => _GroubsscreanState();
}

class _GroubsscreanState extends State<Groubsscrean> {
  bool thestate = false;

  TextEditingController searchController = TextEditingController();
  @override
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
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                )
              : const Text(
                  'My Groubs',
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
              .collection('groubs')
              .where('members',
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Groubmodel> items = snapshot.data!.docs
                  .map((e) => Groubmodel.fromJson(e.data()))
                  .toList();
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Chatgscrean(chatgscrean: items[index],);
                      }));
                    },
                    title: Text(items[index].name!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    leading: CircleAvatar(
                      radius: 20,
                      child: Text(
                        items[index].name!.characters.first,
                      ),
                    ),
                    subtitle: Text(items[index].lastMessage == ''
                        ? 'start messaging'
                        : items[index].lastMessage!,maxLines: 1,overflow:  TextOverflow.ellipsis ,),
                    trailing: Text(items[index].lastMessagetime!),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Container();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CreateGroupPage();
          }));
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
