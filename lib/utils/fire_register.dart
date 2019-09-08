import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:physics_app/utils/cloud_fire.dart';
class FireRegister {
  CloudFire _cloudFire = CloudFire();
  Future<String> signUp(String _email, String _password,String name, String grade) async {
    String status='';
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email, password: _password).then((user){
      status='Register Successfully';
      _cloudFire.createUserRecord(user.user.uid, name, grade);
    }).catchError((onError){
      print(onError);
      status=processError(onError);
    });
    return status;
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