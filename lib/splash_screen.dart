import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashScreen>{
  getToken() async{
    return Timer (Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString('token');
      if (token != null){
        return Navigator.pushReplacementNamed(context, Pages.HomeSkrin);
      }
      return Navigator.pushReplacementNamed(context, Pages.Login);
    });
  }

  @override
  initState(){
    super.initState();
    getToken();
  }

  Widget build(BuildContext context){
    return Scaffold(body: Center(child: CircularProgressIndicator(),));
  }
}