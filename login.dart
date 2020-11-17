import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.45,
                child: Image.asset(
                  'assets/images/shoogir.png',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: usernameC,
                decoration: InputDecoration(
                  hintText: 'Username',
                  suffixIcon: Icon(Icons.supervised_user_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: true,
                controller: passwordC,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Forget password?',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    RaisedButton(
                      child: Text('Login'),
                      color: Color(0xffEE7B23),
                      onPressed: () {
                        if (passwordC.text != null) {
                          // Navigator.pop(context, pin2C.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Second()));
                },
                child: Text.rich(
                  TextSpan(text: 'Don\'t have an account', children: [
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(color: Color(0xffEE7B23)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
