// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  @override
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var buttonSel = [false, false];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MRI Scan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('MRI Scan'),
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                height: 650,
                width: 800,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/mri_scan.jpg'),
                    fit: BoxFit.fitWidth,
                  ), //
                ),
              ),
              ToggleButtons(
                children: const [Icon(Icons.filter_1), Icon(Icons.filter_2)],
                onPressed: (int index) {
                  setState(() {
                    buttonSel[index] = !buttonSel[index];
                  });
                },
                isSelected: buttonSel,
              ),
            ]),
          )),
    );
  }
}
