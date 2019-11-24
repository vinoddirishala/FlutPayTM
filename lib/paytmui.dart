import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;




class PayTmStateLess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App Wallet",
      home: PayTmStateFull(
        title: "App Wallet",
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

  static const platform = const MethodChannel('payment');

  TextEditingController amountController = new TextEditingController();

  String txnResponse = "Please wait...";



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
                            ),)],),),),
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
                            var response = await http.post("<-- your checksum generation url-->",
                            body: "{ORDER_ID:VDTLABS873,TXN_AMOUNT:"+amountController.text+"}");
                            if (response.statusCode == 200) {
                              var jsonResponse = convert.jsonDecode(response.body);
                              String checksumHash = jsonResponse['CHECKSUMHASH'];
                              final String result = await platform.invokeMethod('makePayment',
                                  { "transAmount":"10",
                                    "emailID":"dirishalavinodkumar@gmail.com",
                                    "ORDER_ID":"VDTLABS873",
                                    "CUST_ID":"VDTL955",
                                    "MOBILE_NO":"9876543210",
                                    "CHANNEL_ID":"WAP",
                                    "WEBSITE":"APPSTAGING",
                                    "INDUSTRY_TYPE_ID":"Retail",
                                    "CALLBACK_URL":"https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=VDTLABS873",
                                    "CHECKSUMHASH":checksumHash,
                                    "MID":"<--YOUR MID here -->"

                                  });

                              setState(() {
                                txnResponse = result;
                              });




                            } else {
                              Toast.show("failed", context);
                            }


                           /* final String result = await platform.invokeMethod('makePayment',
                                { "transAmount":amountController.text,
                                  "emailID":"dirishalavinodkumar@gmail.com",
                                  "ORDER_ID":"VDTL955",
                                  "CUST_ID":"VDTL955",
                                  "MOBILE_NO":"7396656645",
                                  "CHANNEL_ID":"WAP",
                                  "WEBSITE":"APPSTAGING",
                                  "INDUSTRY_TYPE_ID":"Retail",
                                  "CALLBACK_URL":"https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=VDTL955",
                                  "CHECKSUMHASH":"w2QDRMgp1234567JEAPCIOmNgQvsi+BhpqijfM9KvFfRiPmGSt3Ddzw+oTaGCLneJwxFFq5mqTMwJXdQE2EzK4px2xruDqKZjHupz9yXev4=",
                                  "MID":"Androi78288874845632"
                                });*/

                            // payment response base screen redirection
                           // result == 0 ? "":"";


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


            new Text("Txn Response:\n\n"+txnResponse),


            
            

          ],
        ),

    );
  }

}