package com.vdtlabs.flutter_app;

import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "paytm";


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                if (call.method.equals("makePayTM")) {
                  String transAmount = call.argument("transAmount");
                  String greetings = helloFromNativeCode();
                  Toast.makeText(MainActivity.this, "intiate paytm trans for "+transAmount, Toast.LENGTH_SHORT).show();
                  result.success(greetings);
                }else {
                  result.notImplemented();
                }
              }});

  }


  private String helloFromNativeCode() {
    return "Hello from Native Android Code";
  }


}

