import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
class FireSignIn{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   String processError(PlatformException error){
    String _errorMessage='';
    switch (error.code) {
      case "ERROR_USER_NOT_FOUND":
        {
          _errorMessage = 'User is not exist. Please Register !';
          break;
        }
      case "ERROR_WRONG_PASSWORD":
        {
          _errorMessage = 'Incorrect password.';
          break;
        }

      default:
        {
          _errorMessage =
          'There was an error logging in. Please try again later.';
          break;
        }
    }
    return _errorMessage;
  }
  Future<String> signIn( String mail, String pass) async {
      FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
          email: mail, password: pass)).user;
      return user.uid;
    }
}