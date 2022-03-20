import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidnew/home/history.dart';
import 'package:covidnew/model/model.dart';
import 'package:covidnew/screens/history.dart';
import 'package:covidnew/screens/home_screen.dart';
import 'package:covidnew/screens/page_account.dart';
import 'package:covidnew/screens/signin_screen.dart';
import 'package:covidnew/utills/reusewidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:covidnew/theme.dart';
import 'package:provider/provider.dart';
import '../utills/color_utills.dart';

class PageDetail extends StatefulWidget {
  const PageDetail({Key? key}) : super(key: key);

  @override
  _PageDetailState createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  final _auth = FirebaseAuth.instance;

  TextEditingController _fNamelNameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _ageTextController = TextEditingController();
  TextEditingController _sexTextController = TextEditingController();

  String vaccine = 'Astra';
  List<String> items = ['อาคาร 17', 'อาคาร 26', 'อาคาร 13'];
  String? selectedItem = 'อาคาร 17';

  List<String> timeVac = ['8.00 - 9.00', '9.00 - 10.00', '10.00 - 11.00'];
  String? selectedTime = '8.00 - 9.00';

  List<String> sexs = ['ชาย', 'หญิง'];
  String? selectedSex = 'ชาย';

  List<String> vaccDose = ['1', '2', '3'];
  String? selectDose = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xff121421),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [Text("")],
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "การจองวัคซีน",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'ชื่อเต็ม'),
                                controller: _fNamelNameTextController,
                                keyboardType: TextInputType.name,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'เบอร์โทรศัพท์'),
                                controller: _phoneTextController,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                      title: const Text("เพศ"),
                                      trailing: new DropdownButton<String?>(
                                        value: selectedSex,
                                        items: sexs
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(item)))
                                            .toList(),
                                        onChanged: (item) =>
                                            setState(() => selectedSex = item),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration:
                                          InputDecoration(labelText: 'อายุ'),
                                      controller: _ageTextController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                title: const Text("ชื่อวัคซีน"),
                                trailing: new DropdownButton<String>(
                                  value: vaccine,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      vaccine = newValue!;
                                    });
                                  },
                                  items: <String>['Astra', 'Pizer', 'Moderna']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ListTile(
                                title: const Text("สถานที่นัดฉีด"),
                                trailing: new DropdownButton<String?>(
                                  value: selectedItem,
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item, child: Text(item)))
                                      .toList(),
                                  onChanged: (item) =>
                                      setState(() => selectedItem = item),
                                ),
                              ),
                              ListTile(
                                title: const Text("เวลานัด"),
                                trailing: new DropdownButton<String?>(
                                  value: selectedTime,
                                  items: timeVac
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item, child: Text(item)))
                                      .toList(),
                                  onChanged: (item) =>
                                      setState(() => selectedTime = item),
                                ),
                              ),
                              ListTile(
                                title: const Text("เข็มที่"),
                                trailing: new DropdownButton<String?>(
                                  value: selectDose,
                                  items: vaccDose
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item, child: Text(item)))
                                      .toList(),
                                  onChanged: (item) =>
                                      setState(() => selectDose = item),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ActionChip(
                          label: Text(
                            'ยืนยันการจองวัคซีน',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.blue,
                          onPressed: () async {
                            FirebaseFirestore firebaseFirestore =
                                FirebaseFirestore.instance;
                            User? user = _auth.currentUser;

                            VaccineModel vaccineModel = VaccineModel();
                            vaccineModel.uid = user!.uid;
                            vaccineModel.name = _fNamelNameTextController.text;
                            vaccineModel.phone = _phoneTextController.text;
                            vaccineModel.age = _ageTextController.text;
                            vaccineModel.sex = selectedSex;
                            vaccineModel.vacc = vaccine;
                            vaccineModel.place = selectedItem;
                            vaccineModel.time = selectedTime;
                            vaccineModel.dose = selectDose;

                            await firebaseFirestore
                                .collection("users")
                                .doc(user.uid)
                                .collection("vaccOser")
                                .add(vaccineModel.toMap());
                            Fluttertoast.showToast(msg: ("จองวัคซีนแล้ว"));

                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => OrderHistoryPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// onPressed: () {
//             FirebaseAuth.instance.signOut().then((value) {
//               print("Sign Out");
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => SignIn()));
//             });
//           }



















//   body: ListView.builder(
//     itemBuilder: (context, int index) {
//       return Card(
//         color: Colors.lightBlueAccent,
//         child: ListTile(
//           title: Text(
//               'จำนวนผู้ติดเชื้อรายใหม่  ${cov[index]['new_case']} จำนวนผู้เสียชีวิตรายใหม่ ${cov[index]['new_death']}',
//               style: TextStyle(fontSize: 20)),
//         ),
//       );
//     },
//     itemCount: cov != null ? cov.length : 0,
//   ),
