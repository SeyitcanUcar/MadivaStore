// ignore_for_file: unnecessary_set_literal, unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:projecommerce/main.dart';
import 'package:uuid/uuid.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class registerPage extends StatefulWidget {
  final List<Map> kelimeler;
  final String seciliDil;
  registerPage(this.kelimeler, this.seciliDil);
  @override
  State<registerPage> createState() => registerPageState(kelimeler, seciliDil);
}

class registerPageState extends State<registerPage> {
  final List<Map> kelimeler;
  String? seciliDil = "";
  registerPageState(this.kelimeler, this.seciliDil);

  String baslikKayitKelime = "";
  String adsoyadKelime = "";
  String emailKelime = "";
  String telefonKelime = "";
  String sifreKelime = "";
  String sifretekrarKelime = "";
  String hesapVarKelime = "";
  String acikTemaKelime = "";
  String kapaliTemaKelime = "";
  String bosKelime = "";
  String emailHataKelime = "";
  String sifreHataKelime = "";
  String kayitTamamKelime = "";
  String sifrelerAyniDegilKelime = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // print("SEÇİLEN DİL_>> " + seciliDil!);
    dilDegistir(seciliDil!, true);
  }

  void dilDegistir(String secilendil, bool ilkAcilis) {
    setState(() {
      baslikKayitKelime = kelimeler[8][secilendil];
      adsoyadKelime = kelimeler[6][secilendil];
      emailKelime = kelimeler[1][secilendil];
      telefonKelime = kelimeler[7][secilendil];
      sifreKelime = kelimeler[2][secilendil];
      sifretekrarKelime = kelimeler[10][secilendil];
      hesapVarKelime = kelimeler[9][secilendil];
      acikTemaKelime = kelimeler[4][secilendil];
      kapaliTemaKelime = kelimeler[5][secilendil];
      bosKelime = kelimeler[14][secilendil];
      emailHataKelime = kelimeler[15][secilendil];
      sifreHataKelime = kelimeler[16][secilendil];
      kayitTamamKelime = kelimeler[17][secilendil];
      sifrelerAyniDegilKelime = kelimeler[19][secilendil];

      seciliDil = secilendil;
      if (!ilkAcilis) {
        Fluttertoast.showToast(
            msg: kelimeler[11][secilendil],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  CollectionReference userRef =
      FirebaseFirestore.instance.collection('kullaniciBilgileri');

  void ekleKullanici(String adSoyad, String email, String telNumber) async {
    DocumentReference userRefdoc =
        userRef.doc(FirebaseAuth.instance.currentUser!.uid);
    await userRefdoc.set({
      'kullaniciAdSoyad': adSoyad,
      'kullaniciMail': email,
      'kullaniciTelefon': telNumber,
      'kullaniciID': FirebaseAuth.instance.currentUser!.uid
    }).whenComplete(() => {
          Fluttertoast.showToast(
              msg: kayitTamamKelime,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0),
          FirebaseAuth.instance.signOut(),
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyApp()))
          /* Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => homeScreen()))*/
        });
  }

  TextEditingController txtTelefonController = new TextEditingController();
  TextEditingController txtEmailController = new TextEditingController();
  TextEditingController txtSifreController = new TextEditingController();
  TextEditingController txtSifreTekrarController = new TextEditingController();
  TextEditingController txtAdSoyadController = new TextEditingController();

/////////////////////////////////////////////////////////////////////
  ///
  Future<void> userCreate(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => {
                ekleKullanici(txtAdSoyadController.text,
                    txtEmailController.text, txtTelefonController.text)
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      //  print('weak-password');
        Fluttertoast.showToast(
            msg: sifreHataKelime,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
      //  print(emailHataKelime);
        Fluttertoast.showToast(
            msg: emailHataKelime,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
  //    print(e);
    }
  }

  ThemeMode _themeMode = ThemeMode.light;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark(),
        themeMode: _themeMode,
        debugShowCheckedModeBanner: false,
        home: new WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
              return false;
            },
            child: Scaffold(
                body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 30,
                            width: 80,
                            height: 200,
                            child: FadeInUp(
                                duration: Duration(seconds: 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/light-1.png'))),
                                )),
                          ),
                          Positioned(
                            left: 140,
                            width: 80,
                            height: 150,
                            child: FadeInUp(
                                duration: Duration(milliseconds: 1200),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/light-2.png'))),
                                )),
                          ),
                          Positioned(
                            right: 40,
                            top: 40,
                            width: 80,
                            height: 150,
                            child: FadeInUp(
                                duration: Duration(milliseconds: 1300),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/clock.png'))),
                                )),
                          ),
                          Positioned(
                            child: FadeInUp(
                                duration: Duration(milliseconds: 1600),
                                child: Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: Center(
                                    child: Text(
                                      baslikKayitKelime,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 5),
                      child: Column(
                        children: <Widget>[
                          FadeInUp(
                              duration: Duration(milliseconds: 1800),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(143, 148, 251, 1)),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color.fromRGBO(
                                                      143, 148, 251, 1)))),
                                      child: TextField(
                                        controller: txtAdSoyadController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: adsoyadKelime,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[700])),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color.fromRGBO(
                                                      143, 148, 251, 1)))),
                                      child: TextField(
                                        controller: txtEmailController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: emailKelime,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[700])),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color.fromRGBO(
                                                      143, 148, 251, 1)))),
                                      child: TextField(
                                        controller: txtTelefonController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: telefonKelime,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[700])),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color.fromRGBO(
                                                      143, 148, 251, 1)))),
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: txtSifreController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: sifreKelime,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[700])),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: txtSifreTekrarController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: sifretekrarKelime,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[700])),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                if (txtAdSoyadController.text == "" ||
                                    txtEmailController.text == "" ||
                                    txtSifreController.text == "" ||
                                    txtSifreTekrarController.text == "" ||
                                    txtTelefonController.text == "") {
                                  Fluttertoast.showToast(
                                      msg: bosKelime,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  if (txtSifreController.text ==
                                      txtSifreTekrarController.text) {
                                    userCreate(txtEmailController.text,
                                        txtSifreController.text);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: sifrelerAyniDegilKelime,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              },
                              child: FadeInUp(
                                  duration: Duration(milliseconds: 1900),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, .6),
                                        ])),
                                    child: Center(
                                      child: Text(
                                        baslikKayitKelime,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ))),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()));
                              },
                              child: FadeInUp(
                                  duration: Duration(milliseconds: 2000),
                                  child: Text(
                                    hesapVarKelime,
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(143, 148, 251, 1)),
                                  ))),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FadeInLeft(
                                        from: 40,
                                        duration: Duration(milliseconds: 1000),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                changeTheme(ThemeMode.light);
                                              });
                                            },
                                            child: Text(acikTemaKelime))),
                                    FadeInLeft(
                                        from: 40,
                                        duration: Duration(milliseconds: 1000),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                changeTheme(ThemeMode.dark);
                                              });
                                            },
                                            child: Text(kapaliTemaKelime))),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          dilDegistir('tr', false);
                                          var collection = FirebaseFirestore
                                              .instance
                                              .collection('ayarlar');
                                          collection
                                              .doc(
                                                  'dilAyarlari') // <-- Doc ID where data should be updated.
                                              .update({'seciliDil': "tr"});
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          child: FadeInLeft(
                                              from: 40,
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/tr.png'))),
                                              )),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          dilDegistir('en', false);
                                          var collection = FirebaseFirestore
                                              .instance
                                              .collection('ayarlar');
                                          collection
                                              .doc(
                                                  'dilAyarlari') // <-- Doc ID where data should be updated.
                                              .update({'seciliDil': "en"});
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          child: FadeInUp(
                                              from: 40,
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/en.png'))),
                                              )),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          dilDegistir('gr', false);
                                          var collection = FirebaseFirestore
                                              .instance
                                              .collection('ayarlar');
                                          collection
                                              .doc(
                                                  'dilAyarlari') // <-- Doc ID where data should be updated.
                                              .update({'seciliDil': "gr"});
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          child: FadeInRight(
                                              from: 40,
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/ger.png'))),
                                              )),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ))));
  }
}
