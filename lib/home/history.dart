// shows all time scan history, buttons view today's history/ all history /to go to home page/ scan again/ option to delete any url

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidnew/screens/home_screen.dart';
import 'package:covidnew/screens/page_home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:covidnew/home/history.dart';
import 'package:covidnew/services/auth_services.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<HistoryPage> createState() => _HistoryPageState(uid);
}

class _HistoryPageState extends State<HistoryPage> {
  final String uid;
  CollectionReference urlcollections =
      FirebaseFirestore.instance.collection('urls');

  _HistoryPageState(this.uid);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false, //iOS
        forceWebView: true, //Android
        enableJavaScript: true, //Android
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> getData(String url) async {
    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
    );
    Map data = json
        .decode(response.body); // Use List instead of Map for all characters

    print(data);

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    data['img'],
                    width: 200,
                    height: 150,
                  ),
                  //const SizedBox(height: 10),
                  Text(
                    data['name'],
                    //style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Born: " + data['born'],
                    //style: TextStyle(),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 20,
                  ),
                  Text(
                    "Occupation: " + data['occupation'].toString(),
                    //style: TextStyle(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Status: " + data['status'],
                    //style: TextStyle(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Aliases: " + data['aliases'].toString(),
                    //style: TextStyle(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Appearance: Seasons " + data['appearance'].toString(),
                    //style: TextStyle(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Actor(s): " + data['portrayed'].toString(),
                    //style: TextStyle(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "First Appearance: " + data['first_appearance'].toString(),
                    //style: TextStyle(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Residence: " + data['residence'].toString(),
                    //style: TextStyle(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    // }
  }

  Future<void> _scanQR() async {
    AppBar(
      backgroundColor: const Color(0xFFFF7D54),
      title: const Text(
        'Scanning Code',
        style: TextStyle(
          fontFamily: 'PrintAble4U',
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      centerTitle: true,
    );
    try {
      var qrResult = await BarcodeScanner.scan();
      setState(
        () {
          urlcollections.doc(uid).collection('url').add(
            {
              'url': qrResult.rawContent,
              'time': DateTime.now(),
            },
          );
        },
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HistoryPage(uid: uid)));
    } on FormatException catch (ex) {
      print('Pressed the Back Button before Scanning');
    } catch (ex) {
      print('Unknown Error $ex');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
              child: const Text(
                'ประวัติการแสกน QR-CODE',
                style: TextStyle(
                    fontFamily: 'PrintAble4U',
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 30.0),
              child: const Text(
                'แสดงประวัติการ แสกน QR-CODE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'PrintAble4U',
                  height: 1.4,
                  color: Color(0xFFA0A0A0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50.0,
                    width: 150.0,
                    child: FloatingActionButton.extended(
                      onPressed: _scanQR,
                      backgroundColor: const Color(0xff1F8DF5),
                      label: const Text(
                        "แสกนอีกครั้ง",
                        style: TextStyle(
                          fontFamily: 'PrintAble4U',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50.0,
                    width: 110.0,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      backgroundColor: Colors.grey[100],
                      label: const Text(
                        "กลับหน้าหลัก",
                        style: TextStyle(
                          fontFamily: 'PrintAble4U',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: urlcollections
                    .doc(uid)
                    .collection('url')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                          child: SizedBox(
                            height: 80,
                            child: ListTile(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              tileColor: Colors.grey[100],
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (ds['url']
                                                .toString()
                                                .startsWith("/character")) {
                                              getData(
                                                  ("https://dark-api.herokuapp.com/api/v1" +
                                                      ds['url'].toString()));
                                            } else {
                                              _launchURL(ds['url']);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.qr_code_2,
                                            size: 40.0,
                                            color: Color(0xff1F8DF5),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              ds['url'],
                                              style: const TextStyle(
                                                fontFamily: 'PrintAble4U',
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            urlcollections
                                                .doc(uid)
                                                .collection('url')
                                                .doc(ds.id)
                                                .delete();
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever_outlined,
                                            size: 25.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const CircularProgressIndicator();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
