import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecommerce/basketPage.dart';
import 'package:projecommerce/main.dart';
import 'package:uuid/uuid.dart';

class CategoryPage extends StatefulWidget {
  final String? title;
  final String? image;
  final String? tag;
  String? secilendil;
  final String? trDil;
  final String? enDil;
  final String? grDil;

  CategoryPage(
      {Key? key,
      this.title,
      this.image,
      this.tag,
      this.secilendil,
      this.enDil,
      this.grDil,
      this.trDil})
      : super(key: key);

  @override
  _CategoryPageState createState() =>
      _CategoryPageState(tag, secilendil, enDil, grDil, trDil);
}

class _CategoryPageState extends State<CategoryPage> {
  final String? tag;
  String? secilendil;
  final String? trDil;
  final String? enDil;
  final String? grDil;
  _CategoryPageState(
      this.tag, this.secilendil, this.enDil, this.grDil, this.trDil);

  List<String> kelimelerTr = [];
  List<String> kelimelerEn = [];
  List<String> kelimelerGr = [];
  String seciliDil = "";
  Future<void> ayarYukleme() async {
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('ayarlar');
    QuerySnapshot querySnapshot = await myCollection.get();
    for (var doc in querySnapshot.docs) {
      if (doc.get("ayarID") == "dilAyarlari") {
        setState(() {
          seciliDil = doc.get("seciliDil");
          if (doc.get("seciliTema").toString() == "Dark") {
            _themeMode = ThemeMode.dark;
          } else {
            _themeMode = ThemeMode.light;
          }

          if (seciliDil == 'tr') {
            baslikTittle = trDil!;
          } else if (seciliDil == 'gr') {
            baslikTittle = grDil!;
          } else if (seciliDil == 'en') {
            baslikTittle = enDil!;
          }
        });
      }
    }
  }

  var uuid = Uuid();
  Future<void> sepetEkle(String urunIDParameter, String urunAd,
      String urunFiyat, String urunURL) async {
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('sepet');
    QuerySnapshot querySnapshot = await myCollection
        .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('urunID', isEqualTo: urunIDParameter)
        .get();
    for (var doc in querySnapshot.docs) {
      int urunAdet = int.parse(doc.get('urunAdet')) + 1;
      ////////////
      var collection = FirebaseFirestore.instance.collection('sepet');
      collection
          .doc(doc.get('sepetID')) //
          .update({
        'urunAdet': urunAdet.toString(),
        'urunAd': urunAd
      }).whenComplete(() => {
                if (seciliDil == "tr")
                  {
                    Fluttertoast.showToast(
                        msg: "Ürün sepete eklenmiştir!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 65, 123, 98),
                        textColor: Colors.white,
                        fontSize: 16.0)
                  }
                else if (seciliDil == "en")
                  {
                    Fluttertoast.showToast(
                        msg: "The product has been added to the cart!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 65, 123, 98),
                        textColor: Colors.white,
                        fontSize: 16.0)
                  }
                else if (seciliDil == "gr")
                  {
                    Fluttertoast.showToast(
                        msg: "Das Produkt wurde dem Warenkorb hinzugefügt!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 65, 123, 98),
                        textColor: Colors.white,
                        fontSize: 16.0)
                  }
              });
      ///////////////////
    }
    if (querySnapshot.docs.length == 0) {
      String randomID = uuid.v4();

      FirebaseFirestore.instance.collection("sepet").doc(randomID).set({
        "sepetID": randomID,
        "urunAd": urunAd,
        "urunAdet": "1",
        "urunFiyat": urunFiyat,
        "urunID": urunIDParameter,
        "urunURL": urunURL,
        "userID": FirebaseAuth.instance.currentUser!.uid,
      }).whenComplete(() => {
            if (seciliDil == "tr")
              {
                Fluttertoast.showToast(
                    msg: "Ürün sepete eklenmiştir!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 65, 123, 98),
                    textColor: Colors.white,
                    fontSize: 16.0)
              }
            else if (seciliDil == "en")
              {
                Fluttertoast.showToast(
                    msg: "The product has been added to the cart!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 65, 123, 98),
                    textColor: Colors.white,
                    fontSize: 16.0)
              }
            else if (seciliDil == "gr")
              {
                Fluttertoast.showToast(
                    msg: "Das Produkt wurde dem Warenkorb hinzugefügt!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 65, 123, 98),
                    textColor: Colors.white,
                    fontSize: 16.0)
              }
          });
    }
  }

  ThemeMode _themeMode = ThemeMode.light;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  String baslikTittle = "";
  void dilDegistir(String secilenpDil) {
    print("sdfsdfsdf: " + trDil!);
    setState(() {
      seciliDil = secilenpDil;
      if (seciliDil == 'tr') {
        baslikTittle = trDil!;
      } else if (seciliDil == 'gr') {
        baslikTittle = grDil!;
      } else if (seciliDil == 'en') {
        baslikTittle = enDil!;
      }
    });
  }

  Future<void> kelimelerYukleme() async {
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('urunler');
    QuerySnapshot querySnapshot = await myCollection.get();
    for (var doc in querySnapshot.docs) {
      setState(() {
        kelimelerEn.add(doc.get("urunAdEn"));
        kelimelerTr.add(doc.get("urunAdTr"));
        kelimelerGr.add(doc.get("urunAdGr"));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kelimelerYukleme();
    ayarYukleme();
    baslikTittle = tag!;
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
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                  ),
                  ActionButton(
                    color: Colors.white,
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
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
              children: <Widget>[
                Hero(
                  tag: baslikTittle,
                  child: Material(
                    child: Container(
                      height: 360,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(widget.image!),
                              fit: BoxFit.cover)),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                              Colors.black.withOpacity(.8),
                              Colors.black.withOpacity(.1),
                            ])),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FadeInUp(
                                        duration: Duration(milliseconds: 1300),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {},
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            FadeInUp(
                                duration: Duration(milliseconds: 1200),
                                child: Text(
                                  baslikTittle,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 7),
                  child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('urunler')
                            .where('urunCategory', isEqualTo: tag)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.6),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];

                              String urunAdDil = "";

                              if (seciliDil == "tr") {
                                urunAdDil = ds['urunAdTr'];
                              } else if (seciliDil == "gr") {
                                urunAdDil = ds['urunAdGr'];
                              } else if (seciliDil == "en") {
                                urunAdDil = ds['urunAdEn'];
                              }

                              return FadeInUp(
                                  duration: Duration(milliseconds: 1500),
                                  child: makeProduct(
                                      image: ds['urunURL'],
                                      title: urunAdDil,
                                      price: ds['urunFiyat'],
                                      urunID: ds['urunID']));
                            },
                          );
                        },
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              dilDegistir('tr');
                              var collection = FirebaseFirestore.instance
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
                              dilDegistir('en');
                              var collection = FirebaseFirestore.instance
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
                              dilDegistir('gr');
                              var collection = FirebaseFirestore.instance
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
                    ))
              ],
            ),
          ),
        ));
  }

  Widget makeProduct({image, title, price, urunID}) {
    return Container(
        height: 500,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(image), fit: BoxFit.contain)),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.1),
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    sepetEkle(urunID, title, price, image);
                  },
                  child: FadeInUp(
                      duration: Duration(milliseconds: 2000),
                      child: Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Icon(
                              Icons.add_shopping_cart,
                              size: 15,
                              color: Colors.grey[700],
                            ),
                          )))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: Text(
                            price,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                      FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: Text(
                            title.substring(
                                    0, title.length < 15 ? title.length : 15) +
                                "...",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
