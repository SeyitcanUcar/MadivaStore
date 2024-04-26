// ignore_for_file: unnecessary_set_literal

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:projecommerce/buyPage.dart';

class basketPage extends StatefulWidget {
  @override
  _basketPageState createState() => _basketPageState();
}

class _basketPageState extends State<basketPage> {
  Future<void> ayarYukleme() async {
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('ayarlar');
    QuerySnapshot querySnapshot = await myCollection.get();
    for (var doc in querySnapshot.docs) {
      if (doc.get("ayarID") == "dilAyarlari") {
        setState(() {
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

  Widget makeProduct({image, title, price, urunAdet, urunIDS, sepetID}) {
    double toplamFiyat = double.parse(price.toString().split(' ')[0]) *
        double.parse(urunAdet.toString());
    return Container(
        height: 300,
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
                  onTap: () {},
                  child: FadeInUp(
                      duration: Duration(milliseconds: 2000),
                      child: Container(
                        child: ItemCount(
                          initialValue: int.parse(urunAdet.toString()),
                          minValue: 0,
                          maxValue: 20,
                          decimalPlaces: 0,
                          onChanged: (value) {
                            var collection =
                                FirebaseFirestore.instance.collection('sepet');
                            collection
                                .doc(sepetID) //
                                .update({
                              'urunAdet': value.toString(),
                              'urunAd': title
                            }).whenComplete(() => {
                                      toplamFiyat = double.parse(
                                              price.toString().split(' ')[0]) *
                                          double.parse(value.toString())
                                    });
                            print('Selected value: $value');
                          },
                        ),
                      ))),
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
                            toplamFiyat.toString() + " TL",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                      FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: Text(
                            title.substring(
                                    0, title.length < 40 ? title.length : 40) +
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark(),
        themeMode: _themeMode,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/buyback.jpg"),
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 30),
                  height: MediaQuery.of(context).size.height / 1.3,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('sepet')
                        .where('userID',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                            childAspectRatio: 1.5),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];

                          return Container(
                            height: 200,
                            child: FadeInUp(
                              duration: Duration(milliseconds: 1500),
                              child: makeProduct(
                                  image: ds['urunURL'],
                                  title: ds['urunAd'],
                                  price: ds['urunFiyat'],
                                  urunAdet: ds['urunAdet'],
                                  sepetID: ds['sepetID'],
                                  urunIDS: ds['urunID']),
                            ),
                          );
                        },
                      );
                    },
                  )),
              Center(
                  child: ArgonButton(
                height: 75,
                roundLoadingShape: true,
                width: 100,
                onTap: (startLoading, stopLoading, btnState) {
                  startLoading();
                  Future.delayed(const Duration(seconds: 2), () {
                    stopLoading();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => buyPage()));
                  });
                },
                loader: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
                child: Icon(
                  Icons.credit_card,
                  size: 40,
                ),
                borderRadius: 5.0,
                color: Color.fromARGB(255, 238, 248, 245),
              ))
            ],
          ),
        ));
  }
}
