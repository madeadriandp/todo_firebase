import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validate/validate.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forms in Flutter',
      home: LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}
class _LoginData {
  String email = '';
  String password = '';
}
class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _LoginData _data = _LoginData();
  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }
  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }
    return null;
  }
  submit(BuildContext context) async {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
      if (_data.email == "adrian@gmail.com" &&
          _data.password == "123456789") {
        final snackBar = SnackBar(
          content: Text('Ready to Go'),
          backgroundColor: Colors.blue,
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', _data.email);
        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.
        _scaffoldKey.currentState.showSnackBar(snackBar);
        Navigator.pushReplacementNamed(context, '/');
      } else {
        final snackBar = SnackBar(
          content: Text('Upsy doopsy!'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }
  textDivider() => Row(children: <Widget>[
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )),
        ),
        Text("Social Login"),
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )),
        ),
      ]);
  loginForm() => Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Please Login First',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.topLeft,
              ),
              TextFormField(
                  keyboardType: TextInputType
                      .emailAddress, // Use email input type for emails.
                  decoration: InputDecoration(
                      hintText: 'you@example.com', labelText: 'Username'),
                  validator: this._validateEmail,
                  onSaved: (String value) {
                    this._data.email = value;
                  }),
              TextFormField(
                  obscureText: true, // Use secure text for passwords.
                  decoration: InputDecoration(
                      hintText: 'Password', labelText: 'Password'),
                  validator: this._validatePassword,
                  onSaved: (String value) {
                    this._data.password = value;
                  }),
              Container(
                margin: EdgeInsets.only(top: 15.0, bottom: 20.0),
                child: Text(
                  'Forgot Password?',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.blue),
                ),
                alignment: Alignment.bottomRight,
              )
            ],
          ),
        ),
      );
  loginButton(BuildContext context) => Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.only(top: 20, right: 0),
        margin: EdgeInsets.only(bottom: 20, top: 20),
        child: RaisedButton(
          elevation: 5,
          textColor: Colors.white,
          padding: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
              width: 150,
              height: 50,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 148, 231, 225),
                      Color.fromARGB(255, 62, 182, 226)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                'Login',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          onPressed: () => submit(context),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: this._formKey,
            child: ListView(
              children: <Widget>[
                Image(
                 // image: AssetImage('asset/awan.jpg'),
                 image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU98YY4_xKPYrF1ciy4JRDrgvvtqIttRdzgAELbGYodeLvzlaT&s'),
                  height: 150,
                  fit: BoxFit.contain,
                ),
                loginForm(),
                loginButton(context),
                textDivider(),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1528999981900-4a4b66b29540?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image(
                              image: NetworkImage(
                                  'https://cdn3.iconfinder.com/data/icons/capsocial-round/500/facebook-512.png'),
                              height: 48),
                          Image(
                              image: NetworkImage(
                                  'https://cdn4.iconfinder.com/data/icons/new-google-logo-2015/400/new-google-favicon-512.png'),
                              height: 48),
                          Image(
                              image: NetworkImage(
                                  'https://cdn1.iconfinder.com/data/icons/somacro___dpi_social_media_icons_by_vervex-dfjq/500/twitter-old.png'),
                              height: 48),
                          Image(
                              image: NetworkImage(
                                  'http://www.vectorico.com/download/social_media/LinkedIn-Icon.png'),
                              height: 48),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'New User? Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}