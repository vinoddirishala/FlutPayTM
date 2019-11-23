import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'dart:async';



class PayTmStateLess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PayTm Integration",
      home: PayTmStateFull(
        title: "PayTM",
      ),
    );
  }
}


class PayTmStateFull extends StatefulWidget {

  PayTmStateFull({Key key,this.title}):super(key:key);
  String title;

  @override
  State createState()=>PayTmState();

}

class PayTmState extends State<PayTmStateFull>{

  static const platform = const MethodChannel('paytm');
  String _responseFromNativeCode = 'Response';
  Future<void> responseFromNativeCode() async {
    String response = "";
    try {
      final String result = await platform.invokeMethod('helloFromNativeCode');
      response = result;
      print("SucessVinod");
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      print("FailVinod");
    }
    setState(() {
      _responseFromNativeCode = response;
      print(_responseFromNativeCode);
    });
  }

  TextEditingController amountController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("App Wallet"),
      ),
      body: new Column(
          children: <Widget>[

            new Container(
              height: 75.0,
              width: MediaQuery.of(context).size.width,
              child: new Card(
                child: new Align(
                  alignment: Alignment.centerLeft,
                  child: new Padding(
                      padding: EdgeInsets.only(left:20.0),
                  child:new Text("Available Balance : 32.0"),)
                ),
                margin: EdgeInsets.all(16),
              ),
            ),



            new Container(
              width: MediaQuery.of(context).size.width,
              child: new Card(
                elevation: 3.0,
                margin: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: new Column(
                  children: <Widget>[

                    new Padding(
                        padding: EdgeInsets.only(left: 15.0,top:20.0,bottom: 10.0),
                        child:new Align(
                      child: new Text("Add Amount to Wallet",
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold
                        ),),
                      alignment: Alignment.centerLeft,
                    ),),


                    new Padding(
                      padding: EdgeInsets.fromLTRB(20,10,20,0),
                      child: new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new TextField(
                          controller: amountController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                              hintText: "Enter Amount",
                              border: OutlineInputBorder(),
                              semanticCounterText: "Enter Amount",
                              hasFloatingPlaceholder: true,

                          ),
                        ),
                      ),),

                    new Padding(
                      padding: EdgeInsets.all(20.0),
                      child: new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Row(
                          children: <Widget>[

                            new Expanded(child: new Container(
                              child: new Text("200",
                                textAlign: TextAlign.center,
                                style: new TextStyle(),),
                            ),),

                            new Expanded(child: new Container(
                              child: new Text("200",
                                textAlign: TextAlign.center,),
                            ),),

                            new Expanded(child: new Container(
                              child: new Text("200",
                                textAlign: TextAlign.center,),
                            ),)
                          ],
                        ),
                      ),
                    ),

                    new Padding(
                      padding: EdgeInsets.all(20.0),
                      child: new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Row(
                          children: <Widget>[


                            new Expanded(child: new Container(
                              child: new Text("200",
                                textAlign: TextAlign.center,
                                style: new TextStyle(

                                ),),
                            ),),

                            new Expanded(child: new Container(
                              child: new Text("200",
                                textAlign: TextAlign.center,),
                            ),),

                            new Expanded(child: new Container(
                              child: new Text("200",
                                textAlign: TextAlign.center,),
                            ),)
                          ],
                        ),
                      ),
                    ),

                    new Padding(
                      padding: EdgeInsets.fromLTRB(20,15,20,25),
                      child: new Container(
                        height: 55.0,
                        width: MediaQuery.of(context).size.width,
                        child: new RaisedButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          onPressed: () async {
                            final String result = await platform.invokeMethod('makePayTM',{"transAmount":amountController.text});

                            },
                          child: new Text("Add Money",style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),),),
                      ),)
                  ],
                ),
              ),


            ),
            
            

          ],
        ),

    );
  }

}