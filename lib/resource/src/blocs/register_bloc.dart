import 'dart:async';

import 'package:flutter/material.dart';
import 'package:physics_app/utils/vaildation.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends ChangeNotifier{
  final _mailController =  BehaviorSubject<String>();
  final _passController =  BehaviorSubject<String>();
  final _nameController =  BehaviorSubject<String>();
  final _buttonController =  BehaviorSubject<bool>();

  Stream<String> get mailController =>_mailController.stream.skip(2);
  Stream<String> get passController =>_passController.stream.skip(2);
  Stream<String> get nameController =>_nameController.stream.skip(2);
  Stream get buttonController => _buttonController.stream;


  static RegisterBloc of(BuildContext context) {
    return Provider.of<RegisterBloc>(context);
  }
  void addMailFieldError(String mail){
    String error=Validation.validateEmail(mail);
    print(error);
    _mailController.sink.add(error);
  }
  void addPassFieldError(String pass){
    String error=Validation.validatePass(pass);
    print(error);
    _passController.sink.add(error);
  }

  void addNameFieldError(String name){
    String error=Validation.validateName(name);
    print(error);
    _nameController.sink.add(error);
  }
  RegisterBloc(){
    Observable.combineLatest3(_mailController, _passController,_nameController, (email,pass,name){
      return Validation.validateEmail(email)== null && Validation.validatePass(pass)== null && Validation.validateName(name)==null;
    }).listen((enable){
      _buttonController.sink.add(enable);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _mailController.close();
    _passController.close();
    _nameController.close();
    _buttonController.close();
    super.dispose();
  }

}