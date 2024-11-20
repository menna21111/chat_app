import 'package:chatsapp/costants/size.dart';
import 'package:flutter/material.dart';


import 'signup.dart';
import 'signinscrean.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screan_size.init(context);
    bool isselected = false;
    return Scaffold(
      body: Container(
        width: screan_size.width,
        height: screan_size.hieght,
        decoration: const BoxDecoration(
          color: Colors.amber,
          image:  DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/plant.jpg'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             SizedBox(height: 120),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'The best \n app for \n your plants',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            const SizedBox(height: 160),
            SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignScrean()));   
                  },
                  child:const Text(
                    'login',
                    style: TextStyle(color:  Color.fromARGB(255, 21, 83, 23)),
                  ),
                )),
            const SizedBox(height: 30),
          Container(
              height: 40,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup() ));

                  // Your onPressed function logic here
                },
                child:const Text(
                  'sign up',
                  style: TextStyle(color:  Color.fromARGB(255, 21, 83, 23)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
