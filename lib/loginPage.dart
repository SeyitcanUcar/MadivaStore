import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecommerce/main.dart';
import 'package:projecommerce/registerPage.dart';



class loginPages extends StatefulWidget {
  @override
  State<loginPages> createState() => loginPageState();
}

class loginPageState extends State<loginPages> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kelimelerYukleme();
  }

  ThemeMode _themeMode = ThemeMode.light;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtSifre = new TextEditingController();

  Future<void> loginUser(String email, String sifre) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: sifre)
          .whenComplete(() => {
                print("-------OK----"),
                if (FirebaseAuth.instance.currentUser!.uid != null)
                  {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyApp()))
                  }
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: kullaniciYokKelime,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: yanlisSifreKelime,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else   {
        Fluttertoast.showToast(
            msg: yanlisSifreKelime2,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  List<Map> kelimeler = [];
  String seciliDil = "";
  Future<void> kelimelerYukleme() async {
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('ayarlar');
    QuerySnapshot querySnapshot = await myCollection.get();
    for (var doc in querySnapshot.docs) {
      if (doc.get("ayarID") == "dilAyarlari") {
        setState(() {
          print("---> **-> " + doc.get("kelimeler").toString());
          kelimeler = List.from(doc.get("kelimeler"));
          seciliDil = doc.get("seciliDil");
          dilDegistir(doc.get("seciliDil"), true);
        });
      }
    }
  }

  String baslikGirisKelime = "";
  String emailKelime = "";
  String sifreKelime = "";
  String hesapYokKelime = "";
  String acikTemaKelime = "";
  String kapaliTemaKelime = "";
  String kullaniciYokKelime = "";
  String yanlisSifreKelime = "";
  String yanlisSifreKelime2 = "";
  String bosKelime = "";

  void dilDegistir(String secilendil, bool ilkAcilis) {
    setState(() {
      baslikGirisKelime = kelimeler[0][secilendil];
      emailKelime = kelimeler[1][secilendil];
      sifreKelime = kelimeler[2][secilendil];
      hesapYokKelime = kelimeler[3][secilendil];
      acikTemaKelime = kelimeler[4][secilendil];
      kapaliTemaKelime = kelimeler[5][secilendil];
      kullaniciYokKelime = kelimeler[12][secilendil];
      yanlisSifreKelime = kelimeler[13][secilendil];
      yanlisSifreKelime2 = kelimeler[18][secilendil];
      bosKelime = kelimeler[14][secilendil];
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
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
                                    image:
                                        AssetImage('assets/images/clock.png'))),
                          )),
                    ),
                    Positioned(
                      child: FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text(
                                baslikGirisKelime,
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
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                        duration: Duration(milliseconds: 1300),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color.fromRGBO(143, 148, 251, 1)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
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
                                  controller: txtEmail,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: emailKelime,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[700])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: txtSifre,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: sifreKelime,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[700])),
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                        onTap: () {
                          if (txtEmail.text == "" || txtSifre.text == "") {
                            Fluttertoast.showToast(
                                msg: bosKelime,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(255, 175, 76, 76),
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            loginUser(txtEmail.text, txtSifre.text);
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
                                  baslikGirisKelime,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      registerPage(kelimeler, seciliDil)));
                        },
                        child: FadeInUp(
                            duration: Duration(milliseconds: 2000),
                            child: Text(
                              hesapYokKelime,
                              style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1)),
                            ))),
                    SizedBox(
                      height: 30,
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
                                    var collection = FirebaseFirestore.instance
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
                                        duration: Duration(milliseconds: 1000),
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
                                    var collection = FirebaseFirestore.instance
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
                                        duration: Duration(milliseconds: 1000),
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
                                    var collection = FirebaseFirestore.instance
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
                                        duration: Duration(milliseconds: 1000),
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
      )),
    );
  }
}
