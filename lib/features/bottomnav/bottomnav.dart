import 'package:chatsapp/costants/colors.dart';
import 'package:flutter/material.dart';

import '../contats/pres/contactscrean.dart';
import '../groub/pres/screans/creategroub.dart';
import '../groub/pres/screans/groubsscrean.dart';
import '../profile/pres/screans/profilescrean.dart';
import '../registerion/presintation/screan/homescrean.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int index = 0;
  List<Widget> pages = [HomeScrean(),Contactscrean(),Groubsscrean(),Profilescrean()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels:true,
        showUnselectedLabels: true,
        currentIndex: index,
        selectedItemColor: kprimarycolor,
        unselectedItemColor: kgreycolor,
          onTap: (currentindex) {
            setState(() {
              index = currentindex;

            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'chats'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'contacts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'settings'),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'group'),
          ]),
    );
  }
}
