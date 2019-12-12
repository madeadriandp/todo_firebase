import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addscreen_cam.dart';
import 'dashboard.dart';
import 'model/to_do.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  int _selectedIndex=0;
    static const List<Widget> _widgetOptions =<Widget>[
    TodoScreen(),
    ProfileScreen(),
  ];

void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //  Future<FormData> photo({path, name}) async {
  //   return FormData.fromMap({
  //     "name":name,
  //     "favorite": false,
  //     "photo": await MultipartFile.fromFile(path, filename:"user-photo")
    
  //   });
  // }

  //  handleTodo(val, path) async {
  //   await Todo.postTodos(photo(path: path,  name: val));
    
  // }

  @override
  Widget build(BuildContext context) {
  Container _bottomNav(int index, IconData logo) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _selectedIndex ==index ? Colors.yellow[800] : Colors.white,
      ),
      margin: EdgeInsets.only(top:4, bottom: 3),
      child: IconButton(
        color: _selectedIndex == index ? Colors.white : Colors.black,
        icon: Icon(logo),
        iconSize: _selectedIndex == index ? 30.0 : 24.0,
        onPressed: (){
          _onItemTapped(index);
        },
      ),
    ) ;    
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        backgroundColor: Colors.yellow[800],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            child: Icon(
              Icons.add_circle_outline,
              size: 45,
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AddScreenCam(handleTodo),
              //   ),
              // );
            },
          ),



      bottomNavigationBar: BottomAppBar(
            notchMargin: 4.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _bottomNav(0, Icons.today),
                _bottomNav(1, Icons.person),
              ],
            ),
          ),


    );
  }

  

  

}