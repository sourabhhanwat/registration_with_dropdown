import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'add_role.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Demo',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
    home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back.jpg"), fit: BoxFit.cover)),
        child: FirstRoute()
//    home: FirstRoute(),
    ),
  ),
  );
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('demo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: 20.00),
              SizedBox(
//              height: 100.0,
//              width: 400.0,
                child: Image.asset(
                  "images/logo.jpg",
//                fit: BoxFit.contain, scale: 0.5
                  height: 200,
                  width: 250,
//                color: Colors.yellow,
                  colorBlendMode: BlendMode.darken,
                  fit: BoxFit.fitWidth,
                ),
              ), //logo
              SizedBox(
                  height: 50.0),
              ButtonTheme(
                minWidth: 200.0,
                height: 35.0,
                child: RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  child: Text('dropdown', style: TextStyle(fontSize: 20),),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddRolePage()),
                    );
                  },
                ),
              ),//create role
              SizedBox(
                  height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
