import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextEditingController customcontroller = new TextEditingController();

class Reciept {
  String transitionType;
  String pAN;
  String amount;
  String fees;
  String transTime;
  String currency;
  String phone;
  String card;
  String meter;
  String result;
  String balance;
  String get getMeter {
    return meter;
  }

  String get getResult {
    return result;
  }

  String get getBalance {
    return balance;
  }

  String get getFees {
    return fees;
  }

  String get getTransTime {
    return transTime;
  }

  String get getCurrency {
    return currency;
  }

  String get getPhone {
    return phone;
  }

  String get getCard {
    return card;
  }

  void set set_phone(String phone) {
    this.phone = phone;
  }

  void set set_result(String result) {
    this.result = result;
  }

  void set set_balance(String balance) {
    this.balance = balance;
  }

  void set set_meter(String meter) {
    this.meter = meter;
  }

  void set set_fees(String fees) {
    this.fees = fees;
  }

  void set set_TransTime(String transtime) {
    this.transTime = transtime;
  }

  void set set_currency(String currency) {
    this.currency = currency;
  }

  String get get_amount {
    return amount;
  }

  void set amountset(String amount) {
    this.amount = amount;
  }

  String get trans_type {
    return transitionType;
  }

  void set trans_type(String type) {
    this.transitionType = type;
  }

  String get pan {
    return pAN;
  }

  void set pan(String pan) {
    this.pAN = pan;
  }
}

Reciept data = new Reciept();

assigndata(k, v) {
  switch (k) {
    case 'TransitionType':
      data.trans_type = v.toString();
      break;
    case 'PAN':
      data.pan = v.toString();
      break;
    case 'amount':
      data.amount = v;
      break;
    case 'card':
      data.card = v;
      break;
    case 'phone':
      data.phone = v;
      break;
    case 'fees':
      data.fees = v;
      break;
    case 'currency':
      data.currency = v;
      break;
    case 'transTime':
      data.transTime = v;
      break;
    case 'meter':
      data.meter = v;
      break;
    case 'balance':
      data.set_balance = v;
      break;
    case 'result':
      data.set_result = v;
      break;
  }
}

createPrintDialog(BuildContext context, Map<String, dynamic> d) {
 records=[];
  d.forEach((k, v) => assigndata2(k, v));
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("print recipt"),
          content: Builder(
            builder: (context) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;

              return Container(
                child: Table(

                    // textDirection: TextDirection.rtl,
                    // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                    // border:TableBorder.all(width: 2.0,color: Colors.red),
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
  switch (k) {
    case 'TransitionType':
      records.add(new Record(k, v));
      break;
    case 'PAN':
      records.add(new Record(k, v));

      break;
    case 'amount':
      records.add(new Record(k, v));

      break;
    case 'card':
      records.add(new Record(k, v));

      break;
    case 'phone':
      records.add(new Record(k, v));

      break;
    case 'fees':
      records.add(new Record(k, v));

      break;
    case 'currency':
      records.add(new Record(k, v));

      break;
    case 'transTime':
      records.add(new Record(k, v));

      break;
    case 'meter':
      records.add(new Record(k, v));

      break;
    case 'balance':
      records.add(new Record(k, v));

      break;
    case 'result':
      records.add(new Record(k, v));

      break;
  }
}
