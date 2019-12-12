import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/addscreen_cam.dart';
import 'package:navigation/editscreen.dart';
import 'package:navigation/model/to_do.dart';

import 'tododescription.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen();
  @override
  State<StatefulWidget> createState(){
    return TodoState();
  }
}

class _InputData{
  String description = "";
  int urutan;
}

_InputData data = _InputData();

class TodoState extends State<TodoScreen> {
  Firestore todos ;
  // bool loading = true;
  bool checkall = false;
  String filtered ="total";
  


  void getTodos() async{
    print("test2");
    var response =await Todo.getTodoFirestore();
    setState(() {
      print("test4");
      todos=response;
      // loading=false;
    });
    print("test3");
  }


  @override
  void initState(){
    print('test');
    super.initState();
    getTodos();

  }

  // Future<FormData> photo({path, name}) async {
  //   return FormData.fromMap({
  //     "name":name,
  //     "favorite": false,
  //     "photo": await MultipartFile.fromFile(path, filename:"user-photo")
    
  //   });
  // }

  // handleTodo(val, path) {
  //   Todo.postTodos(photo(path: path,  name: val));
  //   getTodos();
  // }
  
  //Edit the name of a Todos
  // editTodos(Todo todo, index) {
  //   Todo.editTodo({"name": todo.name}, todo.id);
  //   getTodos();  
  // }

  // removeWidget(Todo todo, index){
  //   Todo.deleteTodo(todo.id);
  //   // print(todo.id);
  //   todos.removeAt(index);
  //   // getTodos();
  // }

  //Change the favorite status of a Todos
  // clickCheckBox(Todo todo, check, index){
  //  Todo.editTodo({"favorite":check}, todo.id);
  //  getTodos();
  // }

  // handleCheckAll(value){
  //   for (var i = 0; i < todos.length; i++) {
  //     Todo.editTodo({'favorite' : value}, todos[i].id);
  //     todos[i].favorite = value;
  //   }
  //   setState(() {
  //     checkall = value;
  //   });
  // }
  

  // handleDeleteAll(){
  //   setState(() {
  //     //int total = kerjaan.length;
  //     for (int i = 0;i<todos.length;i++) {
  //       if(todos[i].favorite==true){
  //         Todo.deleteTodo(todos[i].id);
  //         todos.removeAt(i);
  //         //getTodos();
  //         i--;
  //       }
  //     }
  //     // getTodos();
  //     checkall = false;
  //   });
  // }
  // // int numberChecked(){
  //   int jum = 0;
  //   setState(() {
  //     for (var item in todos){
  //       if(item.favorite){
  //         jum++;
  //       }
  //     }
  //     // for (int i=0; i<todos.length; i++){
  //     //   if(todos[i].favorite==true){
  //     //     jum++;
  //     //   }
  //     // }
  //   });
  //   return jum;
  // }
// TodoState(this.firestore);
// final Firestore firestore ;

  @override
  Widget build(BuildContext context) {   
      
    return 
    StreamBuilder<QuerySnapshot>(
      stream: todos.collection('todo').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        int done = 0;
        int total = snapshot.data.documents.length  ==null
          ? 0
          : snapshot.data.documents.length;
          print("total=$total");
          print('snapshotlength : ${snapshot.data.documents.length}');

        for(var i=0; i<total;i++){
          String data =snapshot.data.documents[i].documentID;
          print(data);
          if(snapshot.data.documents[i]['status'] == true){
            done++;
          }
        }

        int todos = total-done;      
         return 
        //  loading
        // ? Align(
        //   alignment: Alignment.center,
        //   child: 
        // CircularProgressIndicator(backgroundColor: Colors.yellow[800],)//Text('loading')
        
        // ,)
            // :
            Column(children: <Widget>[
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: (
              //   loading
              // ? CircularProgressIndicator()
              // : 
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Box(
                        name: 'Done',
                        color:  Colors.green[700],
                        number: done,
                        icon: Icon(Icons.check_circle)

                      ),

                      Box(
                        name: 'To dos',
                        color: Colors.orange,
                        number: todos,
                        icon: Icon(Icons.airline_seat_recline_normal),

                      ),

                      Box(
                        name: 'Total',
                        color: Colors.blueGrey,
                        number: total,
                        icon: Icon(Icons.assessment)
                      ),
                      
                    ],
                  ))
              ),
         
          Container(
            margin: const EdgeInsets.all(20),
            child: 
            // total==0
            // ? Text("ADD MORE TODOS!")
            // :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: 
                  Column(
                    children: <Widget>[
                      Text("Check All"),
                    Checkbox(
                      value:checkall,
                      onChanged: (val){
                      //  handleCheckAll(val); 
                      }
                    ),

              ],
            ),
          ),

          Container(
                  child: 
                  Column(
                    children: <Widget>[
                      Text("Delete Checked"),
                      RaisedButton.icon(
                        elevation: 0,
                        label: Card(

                        ),
                        color: Colors.transparent,
                        icon: Icon(Icons.delete_outline),
                        onPressed: (){
                          // handleDeleteAll();
                        },
                      )
              ],
            ),
          ),
              ])),



          Expanded(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height*0.57,
            child: (
            ListView.builder(
            itemCount: total,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    // removeWidget(todos[index], index);
              

                    //Show a snackbar
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("${snapshot.data.documents[index]['title']} deleted"), backgroundColor: Colors.red,));
                  },

                  //show a red background as the item is swiped away
                  background: Container(color: Colors.red),
                  child: Card(
                    child: ListTile(
                      leading: 
                      Icon(Icons.casino),
                      // CircleAvatar(child: Image.network(todos[index].imagepath), backgroundColor: Colors.transparent,),
                      trailing: Checkbox(
                        value: snapshot.data.documents[index]['status'],
                        onChanged: (favorite) {
                          // clickCheckBox(todos[index], favorite, index);
                          // if(favorite ==false){
                          //   checkall=false;
                          // }
                          // int temp=0;
                          // for(var i=0; i<todos.length; i++){
                          //   if(todos[i].favorite==true){
                          //     temp++;
                          //   }
                          // }
                          // if(temp == todos.length){
                          //   checkall=true;
                          // }
                        },
                      ),
                      title: 
                      Text(snapshot.data.documents[index]["title"], 
                      style: snapshot.data.documents[index]["status"]
                      ? TextStyle(decoration: TextDecoration.lineThrough,color: Colors.blue[900])
                      : TextStyle(decoration: TextDecoration.none,color: Colors.black)
                      ),
                       
                      onLongPress: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           DetailScreen(
                        //             todo: todos[index]),
                        //     ));
                      },

                      onTap:(){
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //      EditScreen(
                        //        todos:todos[index],
                        //        index: index,
                        //        editTodo: editTodos,
                        //      )
                        //   ),);
                      } ,
                    ),
                  ));
            },
          )
          )),]);

      },
    );
  }}
        // ListView.builder(
        //   itemCount: messageCount,
        //   itemBuilder: (_, int index) {
        //     final DocumentSnapshot document = snapshot.data.documents[index];
        //     final dynamic message = document['message'];
        //     return ListTile(
        //       title: Text(
        //         message != null ? message.toString() : '<No message retrieved>',
        //       ),
        //       subtitle: Text('Message ${index + 1} of $messageCount'),
        //     );
        //   },
        // );


        // Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.yellowAccent[900],
        //   title: Text('To dos'),
        // ),
        // body: 
        
          // bottomNavigationBar: BottomAppBar(
          //   notchMargin: 4.0,
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: <Widget>[
          //       _bottomNav(0, Icons.today),
          //       _bottomNav(1, Icons.person),
          //     ],
          //   ),
          // ),

          
          

//           floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: Colors.teal,
//             child: Icon(
//               Icons.add_circle_outline,
//               size: 45,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddScreenCam(handleTodo),
//                 ),
//               );
//             },
//           ),
//         );
//   }
// }

class Box extends StatelessWidget{

  final String name;
  final Icon icon;
  final int number;
  final Color color;

const Box({Key key, @required this.name, @required this. icon, 
@required this.number, @required this.color}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: MediaQuery.of(context).size.height*2/10,
      child: Material(
        elevation: 10.0,
        child: (
          Column(
            children: <Widget>[
              Text(name,style: TextStyle(color: color, fontSize: 35, fontStyle: FontStyle.italic),),
              Icon(icon.icon, size: 35, color: color,),
              Text(number.toString(), style:TextStyle(color:color, fontSize: 35, fontStyle: FontStyle.italic)),
            ],
          )
        ),
      )
    );
  }

}