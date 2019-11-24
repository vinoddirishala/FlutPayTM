package com.vdtlabs.flutter_app;

import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import com.paytm.pgsdk.PaytmOrder;
import com.paytm.pgsdk.PaytmPGService;
import com.paytm.pgsdk.PaytmPaymentTransactionCallback;


import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "payment";
  String txnStatus = "";


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                if (call.method.equals("makePayment")) {
                  String response = intiatePayTMTrans(call);
                  result.success(response);
                }else {
                  result.notImplemented();
                }
              }});

  }


  private String helloFromNativeCode() {
    return "Hello from Native Android Code";
  }



  private String intiatePayTMTrans(MethodCall call){

    PaytmPGService Service = PaytmPGService.getStagingService();
    Map<String, String> paramMap = new HashMap<>();

    Log.d("PayTMParams",call.argument("MID")+"\n"+call.argument("ORDER_ID")+"\n"+
            call.argument("CUST_ID")+"\n"+call.argument("MOBILE_NO")+"\n"+call.argument("emailID")
    +"\n"+call.argument("CHANNEL_ID")+"\n"+call.argument("transAmount")+"\n"+call.argument("WEBSITE")
    +"\n"+call.argument("INDUSTRY_TYPE_ID")+"\n"+call.argument("CALLBACK_URL")+"\n"+call.argument("CHECKSUMHASH"));




    paramMap.put( "MID" , call.argument("MID"));
    paramMap.put( "ORDER_ID" , call.argument("ORDER_ID"));
    paramMap.put( "CUST_ID" , call.argument("CUST_ID"));
    paramMap.put( "MOBILE_NO" , call.argument("MOBILE_NO"));
    paramMap.put( "EMAIL" , call.argument("emailID"));
    paramMap.put( "CHANNEL_ID" , call.argument("CHANNEL_ID"));
    paramMap.put( "TXN_AMOUNT" , call.argument("transAmount"));
    paramMap.put( "WEBSITE" , call.argument("WEBSITE"));
    paramMap.put( "INDUSTRY_TYPE_ID" , call.argument("INDUSTRY_TYPE_ID"));
    paramMap.put( "CALLBACK_URL", call.argument("CALLBACK_URL"));
    paramMap.put( "CHECKSUMHASH" , call.argument("CHECKSUMHASH"));

    PaytmOrder Order = new PaytmOrder(paramMap);


    Service.initialize(Order, null);

    Service.startPaymentTransaction(this, true, true, new PaytmPaymentTransactionCallback() {
      /*Call Backs*/
      public void someUIErrorOccurred(String inErrorMessage) {
        Toast.makeText(MainActivity.this, "ui error", Toast.LENGTH_SHORT).show();
        txnStatus = "Something went wrong";
      }
      public void onTransactionResponse(Bundle inResponse) {
        Toast.makeText(MainActivity.this, "transaction success"+inResponse.toString(), Toast.LENGTH_SHORT).show();
        txnStatus = inResponse.toString();
      }
      public void networkNotAvailable() {
        Toast.makeText(MainActivity.this, "no network", Toast.LENGTH_SHORT).show();
        txnStatus= "no internet";
      }
      public void clientAuthenticationFailed(String inErrorMessage) {
        Toast.makeText(MainActivity.this, "client auth failed", Toast.LENGTH_SHORT).show();
        txnStatus= "client auth failed";
      }
      public void onErrorLoadingWebPage(int iniErrorCode, String inErrorMessage, String inFailingUrl) {
        Toast.makeText(MainActivity.this, "error loading webpage", Toast.LENGTH_SHORT).show();
        txnStatus= "error loading webpage";
      }

      public void onBackPressedCancelTransaction() {
        Toast.makeText(MainActivity.this, "back pressed", Toast.LENGTH_SHORT).show();
        txnStatus= "back pressed";
      }
      public void onTransactionCancel(String inErrorMessage, Bundle inResponse) {
        Toast.makeText(MainActivity.this, "transaction cancelled", Toast.LENGTH_SHORT).show();
        txnStatus= "transaction cancelled";
      }
    });
    return txnStatus;
  }





}

