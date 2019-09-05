import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:physics_app/resource/src/blocs/log_in_bloc.dart';
import 'package:physics_app/resource/src/page/register_page.dart';
import 'package:physics_app/utils/fire_sign_in.dart';
import 'package:physics_app/utils/screen_size.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FireSignIn _signIn = FireSignIn();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isShowPass = true;
@override
  void initState() {
    // TODO: implement initState
  passController.addListener((){
    LoginBloc.of(context).isEnableButton(emailController.text, passController.text);
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final heightScreen = ScreenSize.heightScreen(context);
    final widthScreen = ScreenSize.widthScreen(context);
    var loginBloc = LoginBloc.of(context);
    void clickOnButton() {
      _signIn.signIn(emailController.text, passController.text).then((user) {
        print('Transform to Home page');
      }).catchError((onError) {
        String error = _signIn.processError(onError);
        print(error);
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: heightScreen * 0.2,
            ),
            Padding(
              padding: EdgeInsets.only(left: widthScreen * 0.05),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'images/albert_einstein.png',
                          height: heightScreen * 0.3,
                          width: widthScreen * 0.3,
                        ),
                        Text(
                          'Physics',
                          style: TextStyle(
                              fontFamily: 'ExodusDemo',
                              fontSize: 56,
                              color: Colors.blueAccent.shade200),
                        )
                      ],
                    ),
                    Positioned(
                        left: widthScreen * 0.1,
                        top: heightScreen * 0.21,
                        child: Text(
                          'Do execrise any where, any time when you want',
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: heightScreen * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: widthScreen * 0.05, right: widthScreen * 0.05),
              child: textFormFiled('Email', 'example@gmail.com', Icons.email,
                  false, emailController, null),
            ),
            SizedBox(
              height: heightScreen * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: widthScreen * 0.05, right: widthScreen * 0.05),
              child: StreamBuilder(
                stream: loginBloc.showPassController,
                builder: (context, snapshot) {
                  return Stack(
                    children: <Widget>[
                      textFormFiled('Password', 'password', Icons.lock, snapshot.hasData?snapshot.data:true,
                          passController, null),
                      Positioned(
                          top: heightScreen * 0.025,
                          left: widthScreen * 0.75,
                          child: GestureDetector(
                            child: Text(
                              _isShowPass ? 'Show' : 'Hide',
                              style: TextStyle(fontSize: 20),
                            ),
                            onTap: () {
                              _isShowPass = loginBloc.showPass(_isShowPass);
                              print(_isShowPass);
                            },
                          ))
                    ],
                  );
                }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: widthScreen * 0.5,
                  right: widthScreen * 0.05,
                  top: heightScreen * 0.02),
              child: SizedBox(
                height: heightScreen * 0.05,
                width: widthScreen * 0.4,
                child: StreamBuilder(
                    stream: loginBloc.buttonController,
                    builder: (context, snapshot) {
                      return RaisedButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Log in',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          onPressed:
                              (snapshot.data ?? false) ? clickOnButton : null);
                    }),
              ),
            ),
            SizedBox(
              height: heightScreen * 0.1,
            ),
            RichText(
              text: TextSpan(
                  text: 'Are you have account ?',
                  style: TextStyle(color: Color(0xff606470), fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Move to registerPage');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                        text: 'Register here !',
                        style:
                            TextStyle(color: Color(0xff3277D8), fontSize: 16)),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget textFormFiled(String tittle, String hint, icon, bool obscureText,
      TextEditingController controller, String error) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: tittle,
          hintText: hint,
          errorText: error,
          icon: Icon(icon),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffCED0D2)),
              borderRadius: BorderRadius.all(Radius.circular(6)))),
    );
  }
}
