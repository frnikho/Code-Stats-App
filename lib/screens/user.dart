import 'dart:async';

import 'package:codestatsapp/models/language.dart';
import 'package:codestatsapp/models/user.dart';
import 'package:codestatsapp/models/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const TextStyle defaultTextStyle = TextStyle(
    fontFamily: "Rubik-Light",
    color: Colors.white,
    fontSize: 40,
    fontWeight: FontWeight.w600);

const primaryColor = Color.fromRGBO(75, 65, 133, 1);

class NoGlowBehavior extends ScrollBehavior {

  @override
  Widget buildViewportChrome(BuildContext context, Widget child,
      AxisDirection axisDirection) {
    return (child);
  }
}

class UserScreen extends StatelessWidget {

  static String id = "user_screen";


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return User(context);
      },
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Consumer<User>(builder: (context, user, child) {
              return ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                            },
                            child: Container(
                                padding: EdgeInsets.all(25),
                                child: Row(
                                  children: [
                                    Text(user.username,
                                        style: TextStyle(
                                            fontFamily: "Rubik-Light",
                                            fontSize: 28,
                                            fontWeight: FontWeight.w700)
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.edit),
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              user.update(context);
                            },
                            child: Container(
                                padding: EdgeInsets.all(15),
                                child: CircleAvatar(
                                  child: Icon(
                                      Icons.refresh, color: Colors.white),
                                  backgroundColor: primaryColor,
                                  radius: 14,
                                )),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(25),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: primaryColor.withOpacity(0.7),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Level ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontFamily: "Rubik-Light")),
                                Text("${user.getLevel()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontFamily: "Rubik-Light",
                                        fontWeight: FontWeight.w800))
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${user.total_xps} ",
                                    style: defaultTextStyle),
                                Text("xp", style: defaultTextStyle.copyWith(
                                    fontSize: 30)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${user.daily_xps} ",
                                  style: defaultTextStyle.copyWith(
                                      fontSize: 30),
                                ),
                                Text("xp today",
                                    style: defaultTextStyle.copyWith(
                                        fontSize: 24)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 6),
                          child: Text("Languages", style: TextStyle(
                              fontFamily: "Rubik-Light",
                              fontSize: 26,
                              fontWeight: FontWeight.w600))
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: LanguageList(user.languages),
                        width: double.infinity,
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      }
    );
  }
}

class LanguageList extends StatelessWidget {

  final List<Language> languages;
  final List<Widget> lists = [];

  LanguageList(this.languages) {
    for (Language language in languages) {
      lists.add(LanguageCard(language: language));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: lists,
    );
  }
}

class LanguageCard extends StatelessWidget {

  final Language language;
  const LanguageCard({Key key, this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        elevation: 2,
        child: Container(
          margin: EdgeInsets.all(22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${language.name}", style: TextStyle(color: Colors.black, fontFamily: "Rubik-Light", letterSpacing: 0.1)),
              Row(
                children: [
                  Text("${language.total_xp} "),
                  Text("xp", style: TextStyle(fontFamily: "Rubik-Light")),
                ],
              ),
              Column(
                children: [
                  Text("level", style: TextStyle(fontFamily: "Rubik-Light")),
                  Text("${language.getLevel()}")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}