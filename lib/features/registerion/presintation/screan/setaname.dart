import 'package:chatsapp/costants/size.dart';
import 'package:chatsapp/firebase/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../../../costants/colors.dart';
import '../widgets/textfield.dart';

class Setaname extends StatelessWidget {
  Setaname({super.key});
  final TextEditingController namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    screan_size.init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
                    height: screan_size.hieght * .23,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: kprimarycolor,
                    ),
                  ),
                ),
                Positioned(
                  top: screan_size.hieght * .05,
                  right: 5,
                  child: IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: screan_size.hieght * .07),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Set your name',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Customtextfield(
              controller: namecontroller,
              hinttext: 'entre your name',
              icon: Icons.person,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screan_size.hieght * .048, vertical: 12),
              child: SizedBox(
                  height: screan_size.hieght * .08,
                  width: screan_size.width * .8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 21, 83, 23),
                    ),
                    onPressed: () async {
                      if (namecontroller.text.isNotEmpty) {
                      await  FirebaseAuth.instance.currentUser!
                            .updateDisplayName(namecontroller.text)
                            .then((value) {
                          FireAuth.createuser();
                        });
                       
                      }
                    },
                    child: const Text(
                      'continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
