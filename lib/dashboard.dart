import 'package:flutter/material.dart';


class Dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dashboard",
      debugShowCheckedModeBanner: false,
      home: new DashboardSF(
        title:"Dashboard"
      ),
    );
  }
  
}


class DashboardSF extends StatefulWidget {

  DashboardSF({Key key,this.title}):super(key:key);
  String title;
  
  @override
  State createState() => DashboardState();
  
}


class DashboardState extends State<DashboardSF>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Dashboard"),
        elevation: 3.0,
      ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        child: new Column(
          children: <Widget>[


            new Expanded(child: new Padding(
              padding: EdgeInsets.all(20),
              child: new Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
                child: new Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: new FittedBox(
                    fit: BoxFit.fill,
                    child: new Image.asset('assets/sliders/slide2.jpg'),
                  ),
                ),
              ),
            ),
            flex: 1,),

            new Expanded(child:  new GridView.builder(
                itemCount: 9,
                gridDelegate:
                new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return new Container(

                    child: new Align(
                      alignment: Alignment.center,
                      child: new Column(
                        children: <Widget>[
                          new Icon(Icons.account_balance_wallet),

                          new Text("Wallet"),

                          
                        ],
                      ),
                    ),
                  );
                }),
            flex: 2,),



          ],
        ),
      ),
    );
  }
}