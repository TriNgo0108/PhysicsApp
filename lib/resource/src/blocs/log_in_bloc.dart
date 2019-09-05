import 'dart:async';

import 'package:flutter/material.dart';
import 'package:physics_app/utils/vaildation.dart';
import 'package:provider/provider.dart';

class LoginBloc extends ChangeNotifier {
  StreamController _buttonController = StreamController();
  StreamController _showPassController = StreamController();

  Stream get buttonController => _buttonController.stream;

  Stream get passController => _buttonController.stream;

  Stream get showPassController => _showPassController.stream;

  void addErrorPass(String error) {
    _showPassController.sink.addError(error);
  }
  bool showPass(bool isShow) {
    bool showPass = !isShow;
    _showPassController.sink.add(showPass);
    return showPass;
  }

  void isEnableButton(String email, String pass) {
    if (Validation.validateEmail(email) == null &&
        Validation.validatePass(pass) == null) return _buttonController.sink.add(true);
    _buttonController.sink.add(false);
  }

  static LoginBloc of(BuildContext context) {
    return Provider.of<LoginBloc>(context);
  }

  void dispose() {
    _buttonController.close();
    _showPassController.close();
    super.dispose();
  }

}
