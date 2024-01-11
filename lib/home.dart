import 'package:flutter/material.dart';
import 'package:ingos/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile.dart';


class Home_page extends StatefulWidget {
  const Home_page({Key, key}): super(key: key);

  @override
  _Home_page createState() => _Home_page();
}

class _Home_page extends State {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.menu), onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => Home_page(),
                          transitionDuration: Duration(milliseconds: 300),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },),
                    Text("Ингосздрав"),
                  ],
                ),
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.notifications), onPressed: () { },),
                    IconButton(icon: Icon(Icons.person), onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => Profile(),
                          transitionDuration: Duration(milliseconds: 300),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },),
                  ],
                ),
              ],
            ),
          ),
          body: Center(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Главная', style: TextStyle(fontSize: 18),),
              Text(uid, style: TextStyle(fontSize: 18),),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => MyApp(),
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