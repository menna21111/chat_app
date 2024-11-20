import 'package:chatsapp/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static User user = auth.currentUser!;
  static Future<void> createuser() async {
    ChatUser chatUser = ChatUser(mycontacts: [],
      id: auth.currentUser!.uid,
      name: auth.currentUser!.displayName??"",
      email: auth.currentUser!.email??'',
      imageUrl: ''
      //  auth.currentUser!.photoURL!,
      ,
      about: auth.currentUser!.displayName??'',
      status: 'online',
      statusMessage: 'I am using ChatsApp',
      createdAt:DateTime.now().millisecondsSinceEpoch.toString(),
      fcmToken: '',
      lastActiveAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );
   await firebaseFirestore.collection('user').doc(user.uid).set(chatUser.toJson());
  }
}
