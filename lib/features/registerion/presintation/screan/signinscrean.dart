import 'package:chatsapp/costants/colors.dart';
import 'package:chatsapp/costants/size.dart';
import 'package:chatsapp/features/registerion/presintation/screan/resetpassword.dart';
import 'package:chatsapp/features/registerion/presintation/screan/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../bottomnav/bottomnav.dart';
import '../widgets/textfield.dart';
import 'homescrean.dart';

class SignScrean extends StatelessWidget {
  SignScrean({super.key});

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
              SizedBox(height: screan_size.hieght * .04),
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: kprimarycolor,
                ),
              ),
              const Text(
                'Login to your account',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: screan_size.hieght * .05),
              Customtextfield(
                func: (Value) {
                  if (Value!.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
                controller: emailController, // Email Controller
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
                controller: passwordController, // Password Controller
                hinttext: 'Enter your password',
                icon: Icons.lock,
              ),
              SizedBox(height: screan_size.hieght * .05),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screan_size.hieght * .05, vertical: 10),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Resetpassword(),
                            ),
                          );
                        },
                        child: const Text('Forgot Password?',
                            style: TextStyle(color: kprimarycolor)))),
              ),
              SizedBox(
                height: screan_size.hieght * .08,
                width: screan_size.width * .8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 21, 83, 23),
                  ),
                  onPressed: () async {
              

                    
                        if (formKey.currentState!.validate()) {
                          try {
                            // Firebase Sign In
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            // Show successful login message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login Successful')),
                            );

                            // Navigate to HomeScreen
                            Navigator.of(context, rootNavigator: true).push(
                              
                              MaterialPageRoute(
                                builder: (context) =>
                                    Bottomnav(),
                              ),
                            );
                          } catch (error) {
                            // Handle error, show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.toString())),
                            );
                          }
                        }
                      }
                    
                  ,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signup(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: kprimarycolor,
                        decoration: TextDecoration.underline,
                        decorationColor: kprimarycolor,
                      ),
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
