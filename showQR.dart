import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:typed_data';

Uint8List bytes = Uint8List(0);

showQRCode(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Scan my card"),
            content: Builder(builder: (context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;

              return Container(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 190,
                    child: bytes.isEmpty
                        ? Center(
                            child: Text('Empty code ... ',
                                style: TextStyle(color: Colors.black38)),
                          )
                        : Image.memory(bytes),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 7, left: 25, right: 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                                flex: 5,
                                child: GestureDetector(
                                    child: Text(
                                  'remove',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue),
                                  textAlign: TextAlign.left,
                                )))
                          ]))
                ]),
                height: height - 4,
                width: width - 4,
              );
            }));
      });
}

generateBarCode(BuildContext context, String inputCode) async {
  Uint8List result = await scanner.generateBarCode(inputCode);
  bytes = result;
  showQRCode(context);
}
