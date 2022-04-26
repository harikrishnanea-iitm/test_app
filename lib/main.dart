// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';
// import 'dart:async';
// import 'dart:ui';

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
  final List<String> svgBox = [
    '<svg width="800" height="650"><rect x="110" y="120" width="150" height="150" style="fill:white;stroke:green;stroke-width:5;fill-opacity:0.0;stroke-opacity:0.9" /></svg>',
    '<svg width="800" height="650"><rect  x="200" y="300" width="200" height="150" style="fill:white;stroke:blue;stroke-width:5;fill-opacity:0.0;stroke-opacity:0.9" /></svg>'
  ];

  // final List<String> svgAsset = [
  //   "assets/images/box0.svg",
  //   "assets/images/box1.svg"
  // ];

  // final String blankSvg = '<svg width="800" height="650"></svg>';
  // final String blankSvgAsset = "assets/images/blank.svg";

  List<bool> buttonSel = [false, false];

  @override
  initState() {
    super.initState();
  }

  fetchButtonState() async {
    return buttonSel;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MRI Scan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
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
                    fit: BoxFit.none,
                  ),
                ),
                child: FutureBuilder(
                  future: fetchButtonState(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    List<Widget> children;

                    if (snapshot.hasData) {
                      var buttonState = snapshot.data;

                      children = [SizedBox.shrink(), SizedBox.shrink()];

                      if (buttonState[0]) {
                        children[0] = SvgPicture.string(svgBox[0]);
                      }
                      if (buttonState[1]) {
                        children[1] = SvgPicture.string(svgBox[1]);
                      }

                      return Stack(
                        children: children,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
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
