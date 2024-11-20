import 'package:chatsapp/costants/colors.dart';
import 'package:chatsapp/costants/size.dart';
import 'package:chatsapp/features/registerion/presintation/screan/setaname.dart';
import 'package:chatsapp/firebase/fire_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/textfield.dart';
import 'homescrean.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                    top: screan_size.hieght * .05,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
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
              SizedBox(
                height: screan_size.hieght * .05,
              ),
              const Text(
                'Registeration',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 28, 108, 30),
                ),
              ),
              const Text(
                'Create new account',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: screan_size.hieght * .05,
              ),
              Column(
                children: [
                  Customtextfield(
                    func: (Value) {
                      if (Value!.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    controller: emailController, // Added controller
                    hinttext: 'Enter your email',
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 15),
                  Customtextfield(
                    func: (Value) {
                      if (Value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    controller: passwordController, // Added controller
                    hinttext: 'Enter your password',
                    icon: Icons.lock,
                  ),
                  SizedBox(
                    height: screan_size.hieght * .08,
                  ),
                  Container(
                    height: screan_size.hieght * .07,
                    width: screan_size.width * .8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 21, 83, 23),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((onValue) {
                            print('done');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Setaname(),
                              ),
                            );
                            // FireAuth.createuser();
                          }).onError((onError, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(onError.toString())));
                          });

                          // Navigate to HomeScrean
                          
                        }
                      },
                      child: const Text(
                        'create account',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'login',
                    style: TextStyle(
                      color: kprimarycolor,
                      decoration: TextDecoration.underline,
                      decorationColor: kprimarycolor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
