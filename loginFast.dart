import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final pin2C = TextEditingController();

String result = 'false';


 Future<String> comparePin(String pin) async {
  final prefs = await SharedPreferences.getInstance();
  final result = prefs.getString("pincode");
  if (result == null) {
    return 'false';
  } else {
    if(result==pin){
      return 'true';
    }
    else{
    return 'false';

    } 
  }
                                   

}

Future doLogin(BuildContext context) {
  

return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            content: Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Container(
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Fast Login',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        obscureText: true,
                        controller: pin2C,
                        decoration: InputDecoration(
                          hintText: 'PinCode',
                          suffixIcon: Icon(Icons.visibility_off),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Forget password?',
                                  style: TextStyle(fontSize: 12.0)),
                              RaisedButton(
                                child: Text('Login'),
                                color: Color(0xffEE7B23),
                                onPressed: () {
                                     var r=  comparePin(pin2C.text);
                                     Navigator.of(context).pop( r);
                                },
                              ),
                            ],
                          ))
                    ])))));
      });

}