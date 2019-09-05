import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:physics_app/resource/src/blocs/register_bloc.dart';
import 'package:physics_app/utils/fire_register.dart';

import 'package:physics_app/utils/screen_size.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List _grades = ['Grade 10', 'Grade 11', 'Grade 12'];
  FireRegister _fireRegister = FireRegister();

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String grade in _grades) {
      items.add(DropdownMenuItem(value: grade, child: Text(grade)));
    }
    return items;
  }

  String _currentValues;

  @override
  void initState() {
    // TODO: implement initState
    _dropDownMenuItems = getDropDownMenuItems();
    _currentValues = _dropDownMenuItems[0].value;
    emailController.addListener((){
      RegisterBloc.of(context).addMailFieldError(emailController.text);
    });
    passController.addListener((){
      RegisterBloc.of(context).addPassFieldError(passController.text);
    });
    nameController.addListener((){
      RegisterBloc.of(context).addNameFieldError(nameController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = ScreenSize.heightScreen(context);
    final widthScreen = ScreenSize.widthScreen(context);
    var registerBloc = RegisterBloc.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: heightScreen * 0.27,
                left: widthScreen * 0.87,
                child: Image.asset(
                  'images/fruit.png',
                  height: heightScreen * 0.08,
                  width: widthScreen * 0.08,
                )),
            Column(
              children: <Widget>[
                SizedBox(
                  height: heightScreen * 0.1,
                ),
                Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'images/nuclear.png',
                          height: heightScreen * 0.3,
                          width: widthScreen * 0.3,
                        ),
                        Text(
                          'REGISTER',
                          style: TextStyle(
                              fontSize: 56,
                              fontFamily: 'ExodusDemo',
                              color: Colors.green),
                        ),
                      ],
                    ),
                    Positioned(
                        top: heightScreen * 0.2,
                        left: widthScreen * 0.4,
                        child: Text(
                          'Easy to make new account',
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: widthScreen * 0.02,
                      right: widthScreen * 0.02,
                      bottom: heightScreen * 0.02),
                  child: StreamBuilder(
                      stream: registerBloc.mailController,
                      builder: (context, snapshot) {
                        return textFormFiled(
                            'Email',
                            'example@gmail.com',
                            Icons.mail,
                            emailController,
                            snapshot.data);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: widthScreen * 0.02,
                      right: widthScreen * 0.02,
                      bottom: heightScreen * 0.02),
                  child: StreamBuilder(
                      stream: registerBloc.passController,
                      builder: (context, snapshot) {
                        return textFormFiled(
                            'Password',
                            'password',
                            Icons.lock,
                            passController,
                            snapshot.data);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: widthScreen * 0.02,
                      right: widthScreen * 0.02,
                      bottom: heightScreen * 0.02),
                  child: StreamBuilder(
                      stream: registerBloc.nameController,
                      builder: (context, snapshot) {
                        return textFormFiled(
                            'Name',
                            'Glenn',
                            Icons.person,
                            nameController,
                            snapshot.data);
                      }),
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                        top: heightScreen*0.00015,
                        bottom: heightScreen*0.009,
                        left: widthScreen * 0.05,
                        child: Image.asset(
                          'images/wormhole.png',
                          height: heightScreen * 0.15,
                          width: widthScreen * 0.15,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: widthScreen * 0.2,
                          right: widthScreen * 0.02,
                          bottom: heightScreen * 0.02),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade100, offset: Offset(0, 3))
                          ], borderRadius: BorderRadius.circular(4)),
                          child: DropdownButton(
                            items: _dropDownMenuItems,
                            value: _currentValues,
                            onChanged: changedDropDownItem,
                            isExpanded: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      heightScreen * 0.15, 0, heightScreen * 0.07, 0),
                  child: SizedBox(
                      width: double.infinity,
                      height: heightScreen * 0.05,
                      child: StreamBuilder(
                        stream: registerBloc.buttonController,
                        builder: (context, snapshot) {
                          return RaisedButton(
                              onPressed: snapshot.hasData ? () {
                                _fireRegister
                                    .signUp(
                                        emailController.text, passController.text)
                                    .then((user) {})
                                    .catchError((onError) {
                                  String error =
                                      _fireRegister.processError(onError);
                                  print(error);
                                });
                              } : null,
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              color: Color(0xff3277D8),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))));
                        }
                      )),
                ),
                SizedBox(
                  height: heightScreen * 0.05,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Have you been account ?',
                      style: TextStyle(color: Color(0xff606470), fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Move to LoginPage');
                                Navigator.pop(context);
                              },
                            text: 'Login here !',
                            style: TextStyle(
                                color: Color(0xff3277D8), fontSize: 16)),
                      ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget textFormFiled(String tittle, String hint, icon,
      TextEditingController controller, String error) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          errorText: error,
          labelText: tittle,
          hintText: hint,
          icon: Icon(icon),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffCED0D2)),
              borderRadius: BorderRadius.all(Radius.circular(6)))),
    );
  }

  void changedDropDownItem(String selectedValues) {
    setState(() {
      _currentValues = selectedValues;
      print(_currentValues);
    });
  }
}
