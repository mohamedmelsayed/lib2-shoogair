import 'dart:async';

import 'package:ShoogairFlutt/pincode.dart';
import 'package:ShoogairFlutt/pincodeLogin.dart';
import 'package:ShoogairFlutt/qrscanner.dart';
import 'package:ShoogairFlutt/showQR.dart';
import 'package:ShoogairFlutt/receipts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'StatelessReceipt.dart';
import 'loginFast.dart';

Future main() async {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: InAppWebViewPage());
  }
}

class InAppWebViewPage extends StatefulWidget {
  @override
  _InAppWebViewPageState createState() => new _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  InAppWebViewController webView;
  Future<String> getPicode() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString("pincode");
    if (result == null) {
      return '';
    } else {
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // appBar: AppBar(
        //     // title: Text("InAppWebView")
        // ),
        body: SafeArea(
            child: Container(
                child: Column(children: <Widget>[
      Expanded(
        child: Container(
          child: InAppWebView(
            initialFile: 'assets/en/login.html',
            initialHeaders: {},
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                debuggingEnabled: true,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
              controller.addJavaScriptHandler(
                  handlerName: "qrcode",
                  callback: (args) {
                    return scanQR(context, "gfhdhfhggdf");
                    //  return "done";
                  });
              controller.addJavaScriptHandler(
                  handlerName: "showQR",
                  callback: (args) {
                    generateBarCode(context, "jkkkkkkkkk");
                    return "done";
                  });
              controller.addJavaScriptHandler(
                  handlerName: "print",
                  callback: (args) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirstRoute(args[0])),
                    );
                    // return createPrintDialog(context, args[0]);
                  });
              controller.addJavaScriptHandler(
                  handlerName: "setpin",
                  callback: (args) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreatePinCode()),
                    );
                  });
              controller.addJavaScriptHandler(
                  handlerName: "getpin",
                  callback: (args) {
                    return getPicode();
                  });
              controller.addJavaScriptHandler(
                  handlerName: "pinlogin",
                  callback: (args) {
                    return doLogin(context);
                  });
            },
            onLoadStart: (InAppWebViewController controller, String url) {},
            onLoadStop: (InAppWebViewController controller, String url) {},
            onConsoleMessage: (InAppWebViewController controller,
                ConsoleMessage consoleMessage) {
              print("console message: ${consoleMessage.message}");
            },
          ),
        ),
      ),
    ]))));
  }
}
