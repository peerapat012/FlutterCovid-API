import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstname;
  String? lastname;
  String? phone;

  UserModel({this.uid, this.email, this.firstname, this.lastname, this.phone});

  // receiving data from server
  factory UserModel.fromMap(map){
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstname: map['firstname'],
        lastname: map['lastname'],
        phone: map['phone']
    );
  }

  // sending data to our sever
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
    };
  }
}

class VaccineModel {
  String? uid;
  String? uidp;
  String? name;
  String? phone;
  String? age;
  String? sex;
  String? place;
  String? time;
  String? vacc;
  String? dose;

  VaccineModel({this.uid, this.uidp, this.name, this.phone, this.age, this.sex, this.place, this.time, this.vacc, this.dose});

  // receiving data from server
  factory VaccineModel.fromMap(map){
    return VaccineModel(
        uid: map['uid'],
        name: map['name'],
        phone: map['phone'],
        age: map['age'],
        sex: map['sex'],
        place: map['place'],
        time: map['time'],
        vacc: map['vacc'],
        dose: map['dose']
    );
  }

  // sending data to our sever
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'sex': sex,
      'age': age,
      'place': place,
      'time': time,
      'vacc': vacc,
      'dose': dose,
    };
  }
}