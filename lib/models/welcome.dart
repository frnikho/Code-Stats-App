import 'package:codestatsapp/screens/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {

  static String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  String _username = "";

  void submit(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
    Navigator.pushReplacementNamed(context, UserScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(25),
                    child: Text("Type your code::stats username", style: TextStyle(fontFamily: "Rubik-Light", fontSize: 30), textAlign: TextAlign.center))),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onSubmitted: (value) {
                    submit(value);
                  },
                  onChanged: (value) {
                    _username = value;
                  },
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                submit(_username);
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
