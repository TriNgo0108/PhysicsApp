import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = ScreenSize.heightScreen(context);
    final widthScreen = ScreenSize.widthScreen(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: heightScreen*0.27,
                left: widthScreen*0.87,
                child: Image.asset(
              'images/fruit.png',
              height: heightScreen * 0.08,
              width: widthScreen * 0.08,
            )),
            Positioned(
                top: heightScreen*0.68,
                left: widthScreen*0.05,
                child: Image.asset(
                  'images/wormhole.png',
                  height: heightScreen * 0.15,
                  width: widthScreen * 0.15,
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
                  child: textFormFiled('Email', 'example@gmail.com', Icons.mail,
                      emailController),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: widthScreen * 0.02,
                      right: widthScreen * 0.02,
                      bottom: heightScreen * 0.02),
                  child: textFormFiled(
                      'Password', 'password', Icons.lock, passController),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: widthScreen * 0.02,
                      right: widthScreen * 0.02,
                      bottom: heightScreen * 0.02),
                  child: textFormFiled(
                      'Name', 'Glenn', Icons.person, nameController),
                ),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(heightScreen*0.15, 0, heightScreen*0.07, 0),
                  child: SizedBox(
                      width: double.infinity,
                      height: heightScreen*0.05,
                      child: RaisedButton(
                          onPressed: (){
                            _fireRegister.signUp(emailController.text, passController.text).then((user){
                            }).catchError((onError){
                             String error = _fireRegister.processError(onError);
                             print(error);
                            });
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: Color(0xff3277D8),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(6))))),
                ),
                SizedBox(height: heightScreen*0.05,),
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

  Widget textFormFiled(
      String tittle, String hint, icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
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
