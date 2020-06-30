import 'package:codestatsapp/models/user.dart';
import 'package:codestatsapp/screens/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>(
      create: (context) {
        return User();
      },
      builder: (context, child) {
        return MaterialApp(
          home: UserScreen(),
        );
      },
    );
  }
}
