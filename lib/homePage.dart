import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecommerce/basketPage.dart';
import 'package:projecommerce/categoryPage.dart';
import 'package:flutter/material.dart';
import 'package:projecommerce/main.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  ThemeMode _themeMode = ThemeMode.light;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  String kisiAdSoyad = "";
  Future<void> kisiBilgisiYukleme() async {
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('kullaniciBilgileri');
    QuerySnapshot querySnapshot = await myCollection
        .where('kullaniciID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (var doc in querySnapshot.docs) {
      setState(() {
        kisiAdSoyad = doc.get("kullaniciAdSoyad");
      });
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
    kelimelerYukleme();
    kisiBilgisiYukleme();
  }

  String acikTemaKelime = "";
  String kapaliTemaKelime = "";
  String homeBaslikKelime = "";
  String hosgeldinKelime = "";
  String kategoriKelime = "";
  String guzellikKelime = "";
  String kiyafetKelime = "";
  String parfumKelime = "";
  String gozlukKelime = "";
  String cantaKelime = "";
  String takiKelime = "";
  String saatKelime = "";
  String tecKelime = "";

  ////////////////////////////////
  String guzellikKelimeen = "";
  String kiyafetKelimeen = "";
  String parfumKelimeen = "";
  String gozlukKelimeen = "";
  String cantaKelimeen = "";
  String takiKelimeen = "";
  String saatKelimeen = "";
  String tecKelimeen = "";
  ////////////////////////////////
  ////////////////////////////////
  String guzellikKelimetr = "";
  String kiyafetKelimetr = "";
  String parfumKelimetr = "";
  String gozlukKelimetr = "";
  String cantaKelimetr = "";
  String takiKelimetr = "";
  String saatKelimetr = "";
  String tecKelimetr = "";
  ////////////////////////////////
  String guzellikKelimegr = "";
  String kiyafetKelimegr = "";
  String parfumKelimegr = "";
  String gozlukKelimegr = "";
  String cantaKelimegr = "";
  String takiKelimegr = "";
  String saatKelimegr = "";
  String tecKelimegr = "";
  ////////////////////////////////
  void dilDegistir(String secilendil, bool ilkAcilis) {
    setState(() {
      acikTemaKelime = kelimeler[4][secilendil];
      kapaliTemaKelime = kelimeler[5][secilendil];
      homeBaslikKelime = kelimeler[20][secilendil];
      hosgeldinKelime = kelimeler[21][secilendil];
      kategoriKelime = kelimeler[22][secilendil];
      guzellikKelime = kelimeler[23][secilendil];
      kiyafetKelime = kelimeler[24][secilendil];
      parfumKelime = kelimeler[25][secilendil];
      gozlukKelime = kelimeler[28][secilendil];
      cantaKelime = kelimeler[26][secilendil];
      takiKelime = kelimeler[27][secilendil];
      saatKelime = kelimeler[29][secilendil];
      tecKelime = kelimeler[30][secilendil];
      //////////////////////////
      guzellikKelimeen = kelimeler[23]['en'];
      kiyafetKelimeen = kelimeler[24]['en'];
      parfumKelimeen = kelimeler[25]['en'];
      gozlukKelimeen = kelimeler[28]['en'];
      cantaKelimeen = kelimeler[26]['en'];
      takiKelimeen = kelimeler[27]['en'];
      saatKelimeen = kelimeler[29]['en'];
      tecKelimeen = kelimeler[30]['en'];
/////////////////////////
      guzellikKelimetr = kelimeler[23]['tr'];
      kiyafetKelimetr = kelimeler[24]['tr'];
      parfumKelimetr = kelimeler[25]['tr'];
      gozlukKelimetr = kelimeler[28]['tr'];
      cantaKelimetr = kelimeler[26]['tr'];
      takiKelimetr = kelimeler[27]['tr'];
      saatKelimetr = kelimeler[29]['tr'];
      tecKelimetr = kelimeler[30]['tr'];
/////////////////////////

      guzellikKelimegr = kelimeler[23]['gr'];
      kiyafetKelimegr = kelimeler[24]['gr'];
      parfumKelimegr = kelimeler[25]['gr'];
      gozlukKelimegr = kelimeler[28]['gr'];
      cantaKelimegr = kelimeler[26]['gr'];
      takiKelimegr = kelimeler[27]['gr'];
      saatKelimegr = kelimeler[29]['gr'];
      tecKelimegr = kelimeler[30]['gr'];
/////////////////////////
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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark(),
        themeMode: _themeMode,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: FadeInRight(
              duration: Duration(milliseconds: 1500),
              child: ExpandableFab(
                distance: 100,
                openIcon: Icon(Icons.home),
                closeIcon: Icon(Icons.close),
                children: [
                  ActionButton(
                    color: Colors.white,
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                  ActionButton(
                    color: Colors.white,
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => basketPage()));
                    },
                  ),
                  ActionButton(
                    color: Colors.white,
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _signOut().whenComplete(() => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp())));
                    },
                  ),
                ],
              )),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.jpg'),
                              fit: BoxFit.cover)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                              Colors.black.withOpacity(.8),
                              Colors.black.withOpacity(.2),
                            ])),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FadeInUp(
                                        duration: Duration(milliseconds: 1500),
                                        child: Text(
                                          homeBaslikKelime,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    FadeInUp(
                                        duration: Duration(milliseconds: 1700),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              hosgeldinKelime +
                                                  ", " +
                                                  kisiAdSoyad,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                kategoriKelime,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              // Text("All")
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 150,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                makeCategory(
                                    image: 'assets/images/beauty.jpg',
                                    title: guzellikKelime,
                                    tag: 'beauty',
                                    secilendill: seciliDil),
                                makeCategory(
                                    image: 'assets/images/clothes.jpg',
                                    title: kiyafetKelime,
                                    tag: 'clothes',
                                    secilendill: seciliDil),
                                makeCategory(
                                    image: 'assets/images/perfume.jpg',
                                    title: parfumKelime,
                                    tag: 'perfume',
                                    secilendill: seciliDil),
                                makeCategory(
                                    image: 'assets/images/glass.jpg',
                                    title: gozlukKelime,
                                    tag: 'glass',
                                    secilendill: seciliDil),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 150,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                makeCategory(
                                    image: 'assets/images/tech-1.jpg',
                                    title: tecKelime,
                                    tag: 'teknoloji',
                                    secilendill: seciliDil),
                                makeCategory(
                                    image: 'assets/images/saat.jpg',
                                    title: saatKelime,
                                    tag: 'saat',
                                    secilendill: seciliDil),
                                makeCategory(
                                    image: 'assets/images/taki.png',
                                    title: takiKelime,
                                    tag: 'taki',
                                    secilendill: seciliDil),
                                makeCategory(
                                    image: 'assets/images/bags.jpg',
                                    title: cantaKelime,
                                    tag: 'canta',
                                    secilendill: seciliDil),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FadeInLeft(
                                            from: 40,
                                            duration:
                                                Duration(milliseconds: 1000),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    changeTheme(
                                                        ThemeMode.light);
                                                    var collection =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'ayarlar');
                                                    collection
                                                        .doc('dilAyarlari') //
                                                        .update({
                                                      'seciliTema': "Light"
                                                    });
                                                  });
                                                },
                                                child: Text(acikTemaKelime))),
                                        FadeInLeft(
                                            from: 40,
                                            duration:
                                                Duration(milliseconds: 1000),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    changeTheme(ThemeMode.dark);
                                                    var collection =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'ayarlar');
                                                    collection
                                                        .doc('dilAyarlari')
                                                        .update({
                                                      'seciliTema': "Dark"
                                                    });
                                                  });
                                                },
                                                child: Text(kapaliTemaKelime))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              dilDegistir('tr', false);
                                              var collection = FirebaseFirestore
                                                  .instance
                                                  .collection('ayarlar');
                                              collection
                                                  .doc('dilAyarlari') //
                                                  .update({'seciliDil': "tr"});
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              child: FadeInLeft(
                                                  from: 40,
                                                  duration: Duration(
                                                      milliseconds: 1000),
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
                                                  .doc('dilAyarlari') //
                                                  .update({'seciliDil': "en"});
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              child: FadeInUp(
                                                  from: 40,
                                                  duration: Duration(
                                                      milliseconds: 1000),
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
                                                  .doc('dilAyarlari') //
                                                  .update({'seciliDil': "gr"});
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              child: FadeInRight(
                                                  from: 40,
                                                  duration: Duration(
                                                      milliseconds: 1000),
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
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget makeCategory({image, title, tag, secilendill}) {
    return AspectRatio(
      aspectRatio: 2 / 2.2,
      child: Hero(
        tag: tag,
        child: GestureDetector(
          onTap: () {
            if (tag == "beauty") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            image: image,
                            title: title,
                            tag: tag,
                            secilendil: secilendill,
                            enDil: guzellikKelimeen,
                            trDil: guzellikKelimetr,
                            grDil: guzellikKelimegr,
                          )));
            } else if (tag == "clothes") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            image: image,
                            title: title,
                            tag: tag,
                            secilendil: secilendill,
                            enDil: kiyafetKelimeen,
                            trDil: kiyafetKelimetr,
                            grDil: kiyafetKelimegr,
                          )));
            } else if (tag == "perfume") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            image: image,
                            title: title,
                            tag: tag,
                            secilendil: secilendill,
                            enDil: parfumKelimeen,
                            trDil: parfumKelimetr,
                            grDil: parfumKelimegr,
                          )));
            } else if (tag == "glass") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            image: image,
                            title: title,
                            tag: tag,
                            secilendil: secilendill,
                            enDil: gozlukKelimeen,
                            trDil: gozlukKelimetr,
                            grDil: gozlukKelimegr,
                          )));
            } else if (tag == "teknoloji") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            image: image,
                            title: title,
                            tag: tag,
                            secilendil: secilendill,
                            enDil: tecKelimeen,
                            trDil: tecKelimetr,
                            grDil: tecKelimegr,
                          )));
            } else if (tag == "saat") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            image: image,
                            title: title,
                            tag: tag,
                            secilendil: secilendill,
                            enDil: saatKelimeen,
                            trDil: saatKelimetr,
                            grDil: saatKelimegr,
                          )));
            } else if (tag == "taki") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            image: image,
                            title: title,
                            tag: tag,
                            secilendil: secilendill,
                            enDil: takiKelimeen,
                            trDil: takiKelimetr,
                            grDil: takiKelimegr,
                          )));
            } else if (tag == "canta") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            image: image,
                            title: title,
                            tag: tag,
                            secilendil: secilendill,
                            enDil: cantaKelimeen,
                            trDil: cantaKelimetr,
                            grDil: cantaKelimegr,
                          )));
            }
          },
          child: Material(
            child: Container(
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover)),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                      Colors.black.withOpacity(.8),
                      Colors.black.withOpacity(.0),
                    ])),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeBestCategory({image, title}) {
    return AspectRatio(
      aspectRatio: 3 / 2.2,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.0),
              ])),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ),
      ),
    );
  }
}
