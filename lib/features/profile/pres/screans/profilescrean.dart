import 'package:chatsapp/costants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/providerapp.dart';

class Profilescrean extends StatelessWidget {
   Profilescrean({super.key});
 
  @override
  Widget build(BuildContext context) {
  final  Prov=Provider.of<Providerapp>(context); 
    return Scaffold(
      appBar: AppBar(
      backgroundColor: kprimarycolor,
         title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ), 
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text('dark mode'),
              trailing: Switch (
                value: Prov.theme==ThemeMode.dark,
              onChanged: (value){
                Prov.changemode(value);
              },) ,
            ),
          )
        ],
      ),
    );
  }
}