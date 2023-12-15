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
    if (flag) {
      String? mail = user!.email;
      final name = user!.displayName?.split(' ')[0];
      final surname = user!.displayName?.split(' ')[1];
      FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .set({
        "Имя": name,
        "Фамилия": surname,
        "mail": mail,
      });
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
          pageBuilder: (context, animation1, animation2) => Home_page(),
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}