import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidnew/camera/qrscan.dart';
import 'package:covidnew/screens/page_account.dart';
import 'package:covidnew/screens/page_detail.dart';
import 'package:covidnew/screens/page_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covidnew/theme.dart';

import '../utills/icons.dart';
import '../utills/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  int currentIndex = 0;
  static const List<Widget> _pages = <Widget>[
    PageHome(),
    PageDetail(),
    Profile()
  ];
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future scan() async {
    try {
      var barcode = await BarcodeScanner.scan();
      print("===================");
      print(barcode);
      print(barcode.type);
      print(barcode.rawContent);
      print(barcode.format);
      print(barcode.formatNote);
      print("==================");
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        print("not have permission to access");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
        onPressed: () {
          final User? user = FirebaseAuth.instance.currentUser;

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Qrscann(uid: user!.uid)));
        },
        child: const Icon(
          Icons.qr_code_2,
          size: 30,
        ),
      ),
      body: Center(
        child: _pages.elementAt(currentIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgAsset(assetName: AssetName.home),
              label: '',
              tooltip: 'Home',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff4A80F0).withOpacity(0.3),
                        offset: Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: SvgAsset(
                  assetName: AssetName.home,
                  color: Color(0xff4A80F0),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgAsset(assetName: AssetName.stethoscope),
              label: '',
              tooltip: 'Hospital',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff4A80F0).withOpacity(0.3),
                        offset: Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: SvgAsset(
                  assetName: AssetName.stethoscope,
                  color: Color(0xff4A80F0),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgAsset(assetName: AssetName.following),
              label: '',
              tooltip: 'Account',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff121421).withOpacity(0.3),
                        offset: Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: SvgAsset(
                  assetName: AssetName.following,
                  color: Color(0xff4A80F0),
                ),
              ),
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          backgroundColor: Color(0xff1C2031),
        ),
      ),
    );
  }
}
