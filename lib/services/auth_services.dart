import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  // current id
  Future<String>  getCurrentUID() async {
    return  (await _auth.currentUser!).uid;
  }

  // currnt user
  Future getCurrentUser() async {
    return await _auth.currentUser!;
  }


  // login
  Future<String?> login(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Logged In";
    }on FirebaseAuthException catch(e){
      // ignore: avoid_print
      print(e.message);
    }
  }

  // signup
  Future<String?> signUp(String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed Up";
    }on FirebaseAuthException catch (e){
      // ignore: avoid_print
      print(e.message);
    }


  }

  //signout
  Future signOut() async {
    try {
      User? user = await _auth.currentUser;
      return await _auth.signOut();
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}

