import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidnew/model/model.dart';
import 'package:covidnew/screens/home_screen.dart';
import 'package:covidnew/screens/page_account.dart';
import 'package:covidnew/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

Stream<QuerySnapshot> getUserVaccineOrderStreamSnapshot(
    BuildContext context) async* {
  String user = FirebaseAuth.instance.currentUser!.uid;
  yield* FirebaseFirestore.instance
      .collection("users")
      .doc(user)
      .collection("vaccOser")
      .snapshots();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  User? user = FirebaseAuth.instance.currentUser;
  VaccineModel vaccineModel = VaccineModel();
  CollectionReference vacc = FirebaseFirestore.instance.collection('vacOder');
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("vacOder")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.vaccineModel = VaccineModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ประวัติการจองวัคซีน"),
        backgroundColor: Color(0xff121421),
      ),
      backgroundColor: Color(0xff121421),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .collection("vaccOser")
            .orderBy("dose", descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var doc = snapshot.data?.docs;
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "วัคซีนเข็มที่ : " + document["dose"],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "ชื่อเต็ม : " + document["name"],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "เพศ : " + document["sex"],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "อายุ : " + document["age"],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "เบอร์ติดต่อ : " + document["phone"],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "วัคซีนที่จอง : " + document["vacc"],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "สถานที่ฉีดวัคซีน : " + document["place"],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "เวลาที่นัด : " + document["time"],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ActionChip(
                            label: Text(
                              'ยกเลิกออเดอร์',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.blue,
                            onPressed: () {
                              FirebaseFirestore firebaseFirestore =
                                  FirebaseFirestore.instance;
                              User? user = _auth.currentUser;

                              firebaseFirestore
                                  .collection("users")
                                  .doc(user!.uid)
                                  .collection("vaccOser")
                                  .doc(document.id)
                                  .delete();

                              Fluttertoast.showToast(
                                  msg: "ยกเลิกออเดอร์สำเร็จ !!");
                              Navigator.pushAndRemoveUntil(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (route) => false);
                            }),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
