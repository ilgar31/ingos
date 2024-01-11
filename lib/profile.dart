import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'welcome.dart';

DateTime selectedDate = DateTime(2000);

class Profile extends StatefulWidget {
  const Profile({Key, key}): super(key: key);

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => MyApp(),
        transitionDuration: Duration(milliseconds: 300),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    );
  }

  final user = FirebaseAuth.instance.currentUser!;
  String number_insurance = '';
  String thirdname = '';

  void getData() {
    final docRef = FirebaseFirestore.instance.collection(
        'Users').doc(
        FirebaseAuth.instance.currentUser?.uid);
    docRef.get().then(
            (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          number_insurance = data["number_insurance"];
          selectedDate = data["Дата рождения"];
          thirdname = data["Отчество"];
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var name = user.displayName?.split(' ')[0];
    var surname = user.displayName?.split(' ')[1];
    getData();

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
                  SizedBox(width: 25,),
                  Text("Личный кабинет"),
                ],
              ),
              Row(
                children: [
                  IconButton(icon: Icon(Icons.notifications), onPressed: () { },),
                  IconButton(icon: Icon(Icons.person), onPressed: () {
                    Navigator.pushReplacement(
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
        Column (
          children: [
            Expanded(
              child: Column(
          children: [
            SizedBox(height: 150,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child:
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Имя",
                ),
                initialValue: name,
                onChanged: (String value) {
                  name = value;
                },
              ),
            ),
            SizedBox(height: 25,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child:
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Фамилия",
                ),
                initialValue: surname,
                onChanged: (String value) {
                  surname = value;
                },
              ),
            ),
            SizedBox(height: 25,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child:
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Отчество (при наличии)",
                ),
                initialValue: thirdname,
                onChanged: (String value) {
                  thirdname = value;
                },
              ),
            ),
            SizedBox(height: 25,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child:
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Номер страхования",
                ),
                initialValue: number_insurance,
                onChanged: (String value) {
                  number_insurance = value;
                },
              ),
            ),
            SizedBox(height: 25,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: CustomDateField(),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                String uid = user!.uid;
                String? mail = user!.email;
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(uid)
                    .set({
                  "Имя": name,
                  "Фамилия": surname,
                  "Отчество": thirdname,
                  "mail": mail,
                  "number_insurance": number_insurance,
                  "Дата рождения": selectedDate,
                });
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Home_page(),
                    transitionDuration: Duration(milliseconds: 300),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
              child: Text("Сохранить", textAlign: TextAlign.center, style: TextStyle(color: Color(
                  0xff1d192b), fontSize: 16, fontWeight: FontWeight.w600),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xfff9dedc),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.85, 45),
                maximumSize: Size(MediaQuery.of(context).size.width * 0.85, 45),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: Color(0xfff9dedc),
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],),),
            ElevatedButton(
              onPressed: () {
                signOut();
              },
              child: Text("Выйти", textAlign: TextAlign.center, style: TextStyle(color: Color(
                  0xff1d192b), fontSize: 16, fontWeight: FontWeight.w600),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xfff9dedc),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.85, 45),
                maximumSize: Size(MediaQuery.of(context).size.width * 0.85, 45),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: Color(0xfff9dedc),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
          ],
        ),
    ));
  }
}


class CustomDateField extends StatefulWidget {
  @override
  _CustomDateFieldState createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1930),
      lastDate: DateTime(2006),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Дата рождения',
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${selectedDate.toLocal()}'.split(' ')[0],
            ),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}