import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidnew/home/history.dart';
import 'package:covidnew/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'dart:async';

class Qrscann extends StatefulWidget {
  const Qrscann({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<Qrscann> createState() => _QrscannState(uid);
}

class _QrscannState extends State<Qrscann> {
  final AuthService _auth = AuthService();
  late final String uid;
  _QrscannState(this.uid);
  CollectionReference urlcollections =
      FirebaseFirestore.instance.collection('urls');

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
      appBar: AppBar(
        backgroundColor: Color(0xff121421),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 40.0),
              child: Image.asset(
                'assests/images/CSR.png',
                height: 200,
                width: 200,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'ยินดีต้อนรับสู่หน้าแสกน QR-CODE',
                style: TextStyle(
                    fontFamily: 'PrintAble4U',
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 20.0),
              child: const Text(
                'โปรดอนุญาติการเข้าถึงกล้อง\n เพื่อแสกน QR-CODE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'PrintAble4U',
                  height: 1.4,
                  color: Color(0xFFA0A0A0),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 60.0,
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: _scanQR,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: const Color(0xff1F8DF5),
            label: const Text(
              "เริ่มแสกน QR Code",
              style: TextStyle(
                fontFamily: 'PrintAble4U',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
