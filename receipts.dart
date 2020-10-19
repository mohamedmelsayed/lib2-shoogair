import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

import 'classes.dart';

File _imageFile;

//Create an instance of ScreenshotController
ScreenshotController screenshotController = ScreenshotController();

TextEditingController customcontroller = new TextEditingController();
String text = '';
String subject = '';
List<String> imagePaths = [];

createPrintDialog(BuildContext context, Map<String, dynamic> d) {
  records = [];
  screenshotController.capture(
      pixelRatio: 1, delay: Duration(milliseconds: 10));
  d.forEach((k, v) => assigndata2(k, v));
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.only(top: 55),
            child: Container(
                child: new Container(
              child: Screenshot(
                  controller: screenshotController,
                  child: Center(
                      child: new Container(
                    color: Colors.white,
                    child: new Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/done90.png'),
                        ),
                        Text(
                          "Success",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        returnTabularInfo()
                      ],
                    ),
                  ))),
            )),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Text("Share"),
              onPressed: () {
                _imageFile = null;
                screenshotController
                    .capture(delay: Duration(milliseconds: 10))
                    .then((File image) async {
                  //print("Capture Done");

                  final result = await ImageGallerySaver.saveImage(
                      image.readAsBytesSync());
                  print("File Saved to Gallery");
                  Uint8List bytes1 = image.readAsBytesSync();
                  ByteData bytes = ByteData.view(bytes1.buffer);
                  await Share.file('esys image', 'esys.png',
                      bytes.buffer.asUint8List(), 'image/png',
                      text: 'ShoogairCash Payment Info');
                }).catchError((onError) {
                  print(onError);
                });
              },
            )
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        );
      });
}

List<Record> records = new List<Record>();
List<TableRow> tableRows = new List<TableRow>();
createRows() {
  tableRows = [];
  for (Record item in records) {
    tableRows.add(new TableRow(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.orange[400],
              width: 1.5,
            )),
        children: [
          Text(
            item.key.toString(),
            textScaleFactor: 0.6,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          Text(item.value.toString(),
              textScaleFactor: 0.6,
              style: TextStyle(color: Colors.black, fontSize: 20)),
        ]));
  }
  return tableRows;
}

assigndata2(k, v) {
  if (k != "PAN") {
    if (k == "MeterNo") {
      caseMeterNo(k, v);
    } else {
      otherwise(k, v);
    }
  } else {
    casePanNo(k, v);
  }
}

caseMeterNo(k, v) {
  String value = v.toString();
  print(value);
  value.replaceAll("\"", "");
  for (var i = 1; i < value.length; i++) {
    if (i % 5 == 0) {
      value = value.substring(0, i) + "-" + value.substring(i, value.length);
    }
  }
  records.add(new Record(k, value));
}

casePanNo(k, v) {
  String value = v.toString();
  String pan = value
      .substring((value.indexOf("-") + 1), value.length)
      .replaceRange(5, 13, "XXXX");
  records.add(new Record(k, pan));
}

otherwise(k, v) {
  if (v.toString().contains("<br/>")) {
    String value = v.toString().substring(0, v.toString().indexOf(("<br/>")));
    records.add(new Record(k, value));
  } else {
    records.add(new Record(k, v));
  }
}

Table returnTabularInfo() {
  return Table(
      textDirection: TextDirection.ltr,
      // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
      children: createRows());
}
