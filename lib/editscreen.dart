import 'package:flutter/material.dart';
import 'package:navigation/model/to_do.dart';

class EditScreen extends StatelessWidget{
  final editTodo;
  final index;
  final Todo todos;

  EditScreen({Key key, @required this.editTodo, @required this.index, @required this.todos}): super(key:key);

  

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,
        title: Text("Edit To Do"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          initialValue: "0",
          
          onFieldSubmitted: (val){
            Todo toda ;
            editTodo(toda, index);
            Navigator.pop(context);
          },
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Edit To Do", labelText: "Add New To Do"),
          ),
        ),
      );
    

  }
}