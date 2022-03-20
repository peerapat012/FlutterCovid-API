import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidnew/model/model.dart';
import 'package:covidnew/screens/home_screen.dart';
import 'package:covidnew/utills/color_utills.dart';
import 'package:covidnew/utills/reusewidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _firstNameTextController = TextEditingController();
  TextEditingController _lastNameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "ลงทะเบียน",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("2C3A57"),
            hexStringToColor("2C3A57"),
            hexStringToColor("2C3A57")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reuseableTextField("ชื่อจริง", Icons.person_outline, false,
                      _firstNameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reuseableTextField("นามสกุล", Icons.person_outline, false,
                      _lastNameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reuseableTextField("อีเมลล์", Icons.mail_outline, false,
                      _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reuseableTextField(
                      "เบอร์โทรศัพท์",
                      Icons.phone_android_outlined,
                      false,
                      _phoneTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reuseableTextField("รหัสผ่าน", Icons.lock_outline, true,
                      _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, false, () {
                    signUp(_emailTextController.text,
                        _passwordTextController.text);
                  })
                ],
              ),
            ),
          ))),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailToFirestore() async {
    // calling firestore
    // calling  our user model
    // sening these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstname = _firstNameTextController.text;
    userModel.lastname = _lastNameTextController.text;
    userModel.phone = _phoneTextController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: ("ลงทะเบียนสำเร็จ"));

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
