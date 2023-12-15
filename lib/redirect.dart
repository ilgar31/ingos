import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'login.dart';


class Redirect extends StatefulWidget {
  const Redirect({Key, key}): super(key: key);

  @override
  _Redirect createState() => _Redirect();
}

class _Redirect extends State {
  final user = FirebaseAuth.instance.currentUser;

  void checkUser(context) async {
    String uid = user!.uid;
    bool flag = true;
    await FirebaseFirestore.instance.collection("Users")
        .get()
        .then((event) {
      for (var doc in event.docs) {
        if (uid == doc.id) {
          flag = false;
          break;
        }
      }
    });
    print(';laskd');
    if (flag) {
      String? name = user!.displayName;
      String? email = user!.email;
      print(name);
      print(email);
      // FirebaseFirestore.instance
      //     .collection("Users")
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .set({
      //   "Телефон": FirebaseAuth.instance.currentUser!.phoneNumber,
      //   "ФИО": "Введите свое ФИО",
      //   "E-mail": "Введите свой E-mail",
      //   "День рождения": "Выберите дату рождения",
      //   "Пол": "Укажите муж/жен"
      // });
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => Login(),
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    }
    else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => Login(),
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    }
  }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   checkUser(context);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text('lskdj'),
      ),);
  }
}