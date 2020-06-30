import 'package:codestatsapp/models/user.dart';
import 'package:codestatsapp/models/welcome.dart';
import 'package:codestatsapp/screens/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<bool> hasUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    if (username == null || username.isEmpty) {
      return (false);
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        UserScreen.id: (context) => UserScreen(),
      },
      home: ChangeNotifierProvider<User>(
        create: (context) {
          return User(context);
        },
        builder: (context, child) {
          Widget screen = WelcomeScreen();
          hasUsername().then((value) => {
            if (value) {
              Navigator.pushReplacementNamed(context, UserScreen.id),
            } else {
              Navigator.pushReplacementNamed(context, WelcomeScreen.id),
            }
          });
          return Text("");
        },
      ),
    );
  }
}
