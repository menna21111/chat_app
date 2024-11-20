import 'package:chatsapp/costants/colors.dart';
import 'package:chatsapp/costants/size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../firebase/firedata.dart';
import '../../../../models/groubmodel.dart';
import '../../../../models/messagemodel.dart';
import '../../../../provider/providerapp.dart';
import '../widget/messagecardg.dart';


class Chatgscrean extends StatefulWidget {
  const Chatgscrean(
      {super.key, required this.chatgscrean,
     });
final Groubmodel chatgscrean;

  @override
  State<Chatgscrean> createState() => _ChatgscreanState();
}

class _ChatgscreanState extends State<Chatgscrean> {

  @override
  Widget build(BuildContext context) {
    final  Prov=Provider.of<Providerapp>(context); 
      bool isdark=Prov.theme==ThemeMode.dark;
    TextEditingController mesgcontroller = TextEditingController();
    screan_size.init(context);
    return Scaffold(
      backgroundColor:isdark?Colors.black: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_outlined)),
                SizedBox(width: 10),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: kprimarycolor,
                ),
                const SizedBox(width: 5),
                Column(
                  children: [
                    Text(
                      widget.chatgscrean.name!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'last message',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('groubs')
                      .doc(widget.chatgscrean.id)
                      .collection('messages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      List<Messagemodel> messages = snapshot.data!.docs
                          .map((e) => Messagemodel.fromJson(e.data()))
                          .toList()
                        ..sort(
                            (e1, e2) => e2.createdAt.compareTo(e1.createdAt));
                      return Expanded(
                        child: ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Messagecardg(
                                
                                roomid: widget.chatgscrean.id!,
                                message: messages[index],
                              );
                            }),
                      );
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isEmpty) {
                      return SizedBox(
                          height: screan_size.hieght * .7,
                          child: Center(
                            child: Text('say hi '),
                          ));
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return Center(
                        child: Container(),
                      );
                    }
                  }),
              Container(
                height: screan_size.hieght * .07,
              )
            ],
          )),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: screan_size.hieght * .07,
                      width: screan_size.width * .8,
                      child: TextField( 
                        maxLines: null,
                        controller: mesgcontroller,
                        decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Message',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(232, 245, 233, 1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(232, 245, 233, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (mesgcontroller.text.isNotEmpty) {
                          Firedata()
                              .sendGmessage(widget.chatgscrean.id!, mesgcontroller.text,
                                )
                              .then((onvalue) {
                            setState(() {
                              mesgcontroller.clear();
                            });
                          });
                        }
                      },
                      child: Icon(Icons.send, size: 30, color: kprimarycolor),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
