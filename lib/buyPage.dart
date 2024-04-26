import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:projecommerce/main.dart';

class buyPage extends StatefulWidget {
  @override
  _buyPageState createState() => _buyPageState();
}

class _buyPageState extends State<buyPage> {
  String secilidil = "";

  String adSoyadKelime = "";
  String krediNoKelime = "";
  String krediAyYilKelime = "";
  String krediGuvenlikNoKelime = "";
  String satinAlKelime = "";
  String satinAlmaBasariliKelime = "";

  List<Map> kelimeler = [];

  void dilDegistir(String secilendil) {
    setState(() {
      adSoyadKelime = kelimeler[31][secilendil];
      krediNoKelime = kelimeler[32][secilendil];
      krediAyYilKelime = kelimeler[33][secilendil];
      krediGuvenlikNoKelime = kelimeler[34][secilendil];
      satinAlKelime = kelimeler[35][secilendil];
      satinAlmaBasariliKelime = kelimeler[36][secilendil];

/////////////////////////
    });
  }

  Future<void> ayarYukleme() async {
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('ayarlar');
    QuerySnapshot querySnapshot = await myCollection.get();
    for (var doc in querySnapshot.docs) {
      if (doc.get("ayarID") == "dilAyarlari") {
        setState(() {
          kelimeler = List.from(doc.get("kelimeler"));
          secilidil = doc.get("seciliDil").toString();
          dilDegistir(secilidil);
          if (doc.get("seciliTema").toString() == "Dark") {
            _themeMode = ThemeMode.dark;
          } else {
            _themeMode = ThemeMode.light;
          }
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ayarYukleme();
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
        home: Scaffold(
            body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/buyback2.jpg"),
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.lighten),
              fit: BoxFit.cover,
            ),
          ),
          margin: EdgeInsets.only(top: 45),
          child: SingleChildScrollView(
              child: Column(
            children: [
              TextFieldContainer2(
                  child: TextField(
                // controller: controllerSec3Text,
                decoration: InputDecoration(
                  labelText: adSoyadKelime,
                  hintText: adSoyadKelime,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person),
                  ),
                ),
              )),
              SizedBox(
                height: 10,
              ),
              TextFieldContainer2(
                  child: TextField(
                // controller: controllerSec3Text,
                decoration: InputDecoration(
                  labelText: krediNoKelime,
                  hintText: krediNoKelime,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.credit_card),
                  ),
                ),
              )),
              SizedBox(
                height: 10,
              ),
              TextFieldContainer2(
                  child: TextField(
                // controller: controllerSec3Text,
                decoration: InputDecoration(
                  labelText: krediAyYilKelime,
                  hintText: krediAyYilKelime,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.date_range),
                  ),
                ),
              )),
              SizedBox(
                height: 10,
              ),
              TextFieldContainer2(
                  child: TextField(
                // controller: controllerSec3Text,
                decoration: InputDecoration(
                  labelText: krediGuvenlikNoKelime,
                  hintText: krediGuvenlikNoKelime,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.numbers),
                  ),
                ),
              )),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: ArgonButton(
                height: 75,
                roundLoadingShape: true,
                width: 100,
                onTap: (startLoading, stopLoading, btnState) {
                  startLoading();
                  Future.delayed(const Duration(seconds: 2), () {
                    stopLoading();
                    Fluttertoast.showToast(
                        msg: satinAlmaBasariliKelime,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 46, 120, 33),
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  });
                },
                loader: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
                child: Text(satinAlKelime),
                borderRadius: 5.0,
                color: Color.fromARGB(255, 238, 248, 245),
              ))
            ],
          )),
        )));
  }
}

class TextFieldContainer2 extends StatelessWidget {
  final Widget child;
  const TextFieldContainer2({
    required this.child,
  }) : super();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
