import 'package:flutter/material.dart';
import 'package:navigation/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen();
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        RaisedButton(
          child: Text("Logout"),
          onPressed: () async{
            final logout = await SharedPreferences.getInstance();
            logout.remove("token");
            Navigator.pushReplacementNamed(context, Pages.Splash);
          },

        )
      
    );
  }
}