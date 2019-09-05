import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
class FireRegister {
  Future<void> signUp(String _email, String _password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email, password: _password).then((user){
    });
  }
  String processError(PlatformException error){
    String _errorMessage='';
    switch (error.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        {
          _errorMessage = 'Email address is already in use by another account';
          break;
        }
      case "ERROR_WEAK_PASSWORD":
        {
          _errorMessage = 'Choose Strong password';
          break;
        }

      default:
        {
          _errorMessage =
          'There was an error register !. Please try again later.';
          break;
        }
    }
    return _errorMessage;
  }

}