import 'dart:async';
import 'dart:convert';
import 'package:covidnew/main.dart';
import 'package:covidnew/screens/map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utills/color_utills.dart';
import 'package:intl/intl.dart';
import 'package:covidnew/theme.dart';
import 'package:intl/date_symbol_data_local.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  DateTime now = new DateTime.now();
  static const String _url17 = 'https://goo.gl/maps/JTS3r82eZxQPXAyJA';
  static const String _url26 = 'https://g.page/scisrcku?share';
  static const String _url13 = 'https://goo.gl/maps/9cc2J4LJHwKP6Foq8';
  var cov;
  Future<Null> getUsers() async {
    var url =
        Uri.parse("https://covid19.ddc.moph.go.th/api/Cases/today-cases-all");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print("Connected");
      setState(() {
        cov = jsonResponse;
      });
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    cov != null ? cov.length : 0;
    var f = NumberFormat("#,##0.##", "en_US");
    var now = DateTime.now();
    var formatter = DateFormat('ข้อมูลประจำวันที่ d เดือน MMM ปี y');
    Intl.defaultLocale = 'th';
    initializeDateFormatting();

    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: ListView.builder(
        itemBuilder: (context, int index) {
          return Card(
              color: Color(0xff121421),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${formatter.format(now)}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                              height: 90,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    hexStringToColor("FC67A7"),
                                    hexStringToColor("F6815B"),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "ติดเชื้อรายใหม่",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${f.format((cov[index]['new_case']))} ราย",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(width: 24),
                            Expanded(
                                child: Container(
                              height: 90,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    hexStringToColor("FC67A7"),
                                    hexStringToColor("F6815B"),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "ติดเชื้อสะสม",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${f.format(cov[index]['total_case'])} ราย",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                              height: 90,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    hexStringToColor("441DFC"),
                                    hexStringToColor("4E81EB"),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "เสียชีวิตรายใหม่",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${f.format(cov[index]['new_death'])} ราย",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(width: 24),
                            Expanded(
                                child: Container(
                              height: 90,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    hexStringToColor("441DFC"),
                                    hexStringToColor("4E81EB"),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "เสียชีวิตสะสม",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${f.format(cov[index]['total_death'])} ราย",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                              height: 90,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    hexStringToColor("13DEA0"),
                                    hexStringToColor("06B782"),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "รักษาหายรายใหม่",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${f.format(cov[index]['new_recovered'])} ราย",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(width: 24),
                            Expanded(
                                child: Container(
                              height: 90,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    hexStringToColor("13DEA0"),
                                    hexStringToColor("06B782"),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "รักษาหายสะสม",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${f.format(cov[index]['total_recovered'])} ราย",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "แนะนำการป้องกันเชื้อโรค",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                        "assests/images/avoid_close_contact.svg"),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "รักษาระยะห่าง",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                        "assests/images/clean_hands.svg"),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "ล้างมือบ่อยๆ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                        "assests/images/wear_facemask.svg"),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "ใส่หน้ากากอนามัย\nตลอดเวลา",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                _launchURLOneSeven();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => MapSCreen()));
                              },
                              child: Text("สถานที่ตึก 17",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                _launchURLOneThree();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => MapSCreen()));
                              },
                              child: Text("สถานที่ตึก 13",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                _launchURLTwoSix();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => MapSCreen()));
                              },
                              child: Text("สถานที่ตึก 26",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        },
        itemCount: cov != null ? cov.length : 0,
      ),
    );
  }

  void _launchURLOneSeven() async {
    if (!await launch(_url17)) throw 'Could not launch $_url17';
  }

  void _launchURLTwoSix() async {
    if (!await launch(_url26)) throw 'Could not launch $_url26';
  }

  void _launchURLOneThree() async {
    if (!await launch(_url13)) throw 'Could not launch $_url13';
  }
}
