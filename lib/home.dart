import 'package:flutter/material.dart';
import 'package:ingos/main.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Home extends StatefulWidget {
  const Home({Key, key}): super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff165ab7),
            title: Text("Главная", style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold)),
          ),
          body: Center(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Вы успешно зашли на аккаунт', style: TextStyle(fontSize: 18),),
              Text('скоро тут появится контент', style: TextStyle(fontSize: 18),),
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
      ),);
  }
}