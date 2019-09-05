import 'package:flutter/material.dart';
import 'package:physics_app/resource/src/blocs/log_in_bloc.dart';
import 'package:physics_app/resource/src/page/log_in_page.dart';
import 'package:provider/provider.dart';
class PhysicsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physics Execrise',
      home: ChangeNotifierProvider(
        builder: (_)=>LoginBloc(),
        child: LoginPage(),
      ),
    );
  }
}
