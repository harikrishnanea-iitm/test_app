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
    '<svg width="800" height="650"><rect x="10" y="20" width="150" height="150" style="fill:white;stroke:green;stroke-width:5;fill-opacity:0.0;stroke-opacity:0.9" /></svg>',
    '<svg width="800" height="650"><rect  x="100" y="200" width="200" height="150" style="fill:white;stroke:blue;stroke-width:5;fill-opacity:0.0;stroke-opacity:0.9" /></svg>'
  ];

  final List<String> svgAsset = [
    "assets/images/box0.svg",
    "assets/images/box1.svg"
  ];

  final String blankSvg = '<svg width="800" height="650"></svg>';
  final String blankSvgAsset = "assets/images/blank.svg";

  String box0 = '<svg width="800" height="650"></svg>';
  String box1 = '<svg width="800" height="650"></svg>';

  List<bool> buttonSel = [false, false];

  @override
  initState() {
    super.initState();
    fetchButtonState();
  }

  fetchButtonState() async {
    print("fetch state");
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
                child: Stack(children: [
                  SvgPicture.string(box0),
                  SvgPicture.string(box1)
                  // CustomPaint(painter: svgPainter(svgBox0, buttonSel[0])),
                  // CustomPaint(painter: svgPainter(svgBox1, buttonSel[1]))
                ]),
              ),
              ToggleButtons(
                children: const [Icon(Icons.filter_1), Icon(Icons.filter_2)],
                onPressed: (int index) {
                  setState(() {
                    buttonSel[index] = !buttonSel[index];

                    if (buttonSel[0]) {
                      box0 = svgBox[0];
                    } else {
                      box0 = blankSvg;
                    }

                    if (buttonSel[1]) {
                      box1 = svgBox[1];
                    } else {
                      box1 = blankSvg;
                    }

                    // fetchButtonState();
                  });
                },
                isSelected: buttonSel,
              ),
            ]),
          )),
    );
  }
}
