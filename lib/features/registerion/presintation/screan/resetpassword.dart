import 'package:chatsapp/costants/colors.dart';
import 'package:chatsapp/costants/size.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/textfield.dart';
import 'homescrean.dart';

class Resetpassword extends StatelessWidget {
  Resetpassword({super.key});

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screan_size.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipperOne(),
                    child: Container(
                      height: screan_size.hieght * .25,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: kprimarycolor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 8,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: screan_size.hieght * .15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'entre your email to reset your password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screan_size.hieght * .05),
              Customtextfield(
                controller: emailController, // Email Controller
                hinttext: 'Enter your email',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 15),
              SizedBox(height: screan_size.hieght * .05),
              SizedBox(
                height: screan_size.hieght * .08,
                width: screan_size.width * .8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 21, 83, 23),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(
                      email: emailController.text,
                    )
                        .then((onValue) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Check your email'),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  HomeScrean(myemail: emailController.text,),
                        ),
                      );
                    }).onError(
                      (error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error.toString()),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Send Email',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
