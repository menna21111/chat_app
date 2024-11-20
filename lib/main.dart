import 'package:chatsapp/features/registerion/data/cubit.dart';
import 'package:chatsapp/features/registerion/presintation/screan/homescrean.dart';
import 'package:chatsapp/features/registerion/presintation/screan/signinscrean.dart';
import 'package:chatsapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'features/bottomnav/bottomnav.dart';
import 'features/registerion/data/cubit/changes_cubit.dart';
import 'features/registerion/presintation/screan/setaname.dart';
import 'provider/providerapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Providerapp(),
      child: Consumer<Providerapp>(builder: (context, Providerapp provider, Widget? child) {
        return MaterialApp(
          darkTheme:ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,brightness: Brightness.dark),

          )
       ,   theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,brightness: Brightness.light),
     useMaterial3: true     ) ,
            debugShowCheckedModeBanner: false,
            themeMode: provider.theme,
            home: StreamBuilder(
                //streambuilder بيرجع في التوقيت اللحظي
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (FirebaseAuth.instance.currentUser!.displayName ==
                            null ||
                        FirebaseAuth.instance.currentUser!.displayName == "") {
                      return Setaname();
                    } else {
                      return Bottomnav();
                    }
                  } else {
                    return SignScrean();
                  }
                }));
      }),
    );
  }
}
