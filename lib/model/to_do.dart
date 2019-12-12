import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';

class Todo {

  
  final String name;
  final String address;
   bool favorite=false;
  final int id;
  final String imagepath;

   
  

  Todo(this.name, this.address, this.favorite, this.id, this.imagepath);

  Todo.fromJson(Map<String, dynamic> response)

    : name = response['name'],
      address = response['address'],
      favorite =response['favorite'],
      id =response['id'],
      imagepath = response['image_url'];

static getTodoFirestore() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'test',
    options: const FirebaseOptions(
      googleAppID: '1:763914117284:android:f8bd43c53cc5d282848631',
      gcmSenderID: '763914117284',
      apiKey: 'AIzaSyBM-s66yBP0iMs0BJgDbdtHh-MrI_VE_b4',
      projectID: 'todo-app-8e801',
    ),
  );
   final Firestore firestore = Firestore(app: app);
    print("test10");
   return firestore;

  // runApp(MaterialApp(
  //     title: 'Firestore Example', home: MyHomePage(firestore: firestore)));
}
  static getTodos() async{
    var response =
    await Dio().get("https://address-book-exp-api.herokuapp.com/users");

    List<Todo> todos = (response.data['data']as List)
      .map((item) =>Todo.fromJson(item))
      .toList();
      
  return todos; }

  static postTodos(data) async {
    var response = await Dio()
    .post("https://address-book-exp-api.herokuapp.com/users", data: await data);

    return response;
  }

  static editTodo(data,id) async{
    var response = await Dio().patch(
      "https://address-book-exp-api.herokuapp.com/users/$id",
      data:data,
    );
    return response;
    }

  static deleteTodo(id) async{
    var response = await Dio()
    .delete("https://address-book-exp-api.herokuapp.com/users/$id");
    return response;
  }

  }


