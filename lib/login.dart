import 'package:flutter/material.dart';


class loginscreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(

    home: LoginPage(title:"Login Demo"),
    );

  }
}


class LoginPage extends StatefulWidget{


  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Demo Login"),
      ),
    );
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();



}

class _MyHomePageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius:BorderRadius.circular(5)),
                    hintText: 'Please enter a search term',

                ),
              ),
              TextField(
                textAlign: TextAlign.center,
              ),
              FlatButton(),

          ],
        ),

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      ),
    );
  }
}
