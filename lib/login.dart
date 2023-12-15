import 'package:flutter/material.dart';
import 'package:ingos/main.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget {
  const Login({Key, key}): super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    return Scaffold(
          body: Center(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Вы успешно зашли на аккаунт (2)', style: TextStyle(fontSize: 18),),
              Text(uid, style: TextStyle(fontSize: 18),),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => MyHomePage(),
                      transitionDuration: Duration(milliseconds: 300),
                      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                    ),
                  );
                },
                child: Text("Выйти из аккаунта", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff165ab7),
                  minimumSize: Size(250, 70),
                  elevation: 10,
                  shadowColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),
              ),
            ],
          ),)
    );
  }
}