import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextEditingController customcontroller = new TextEditingController();

createPrintDialog(BuildContext context, Map<String, dynamic> d) {
  records = [];
  d.forEach((k, v) => assigndata2(k, v));
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Payment Info",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          content: Builder(
            builder: (context) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;

              return Container(
                child: Table(
                    textDirection: TextDirection.ltr,
                    // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                    children: createRows()),
                height: height - 4,
                width: width - 4,
              );
            },
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text("submit"),
              onPressed: () {},
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
    tableRows.add(new TableRow(children: [
      Text(item.key.toString(), textScaleFactor: 0.8),
      Text(item.value.toString(), textScaleFactor: 0.8),
    ]));
  }
  return tableRows;
}

class Record {
  String key;
  String value;

  Record(String k, String v) {
    this.key = k;
    this.value = v;
  }
  String get get_key {
    return key;
  }

  String get get_value {
    return value;
  }

  void set setKey(String key) {
    this.key = key;
  }

  void set setValue(String value) {
    this.value = value;
  }
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
