// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore: avoid_web_libraries_in_flutter, unused_import
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
    '<svg width="800" height="650"><rect x="210" y="220" width="150" height="150" style="fill:white;stroke:green;stroke-width:5;fill-opacity:0.0;stroke-opacity:0.9" /></svg>',
    '<svg width="800" height="650"><rect  x="300" y="400" width="200" height="150" style="fill:white;stroke:blue;stroke-width:5;fill-opacity:0.0;stroke-opacity:0.9" /></svg>'
  ];

  final List<String> svgAsset = [
    'assets/images/box0.svg',
    'assets/images/box1.svg'
  ];

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
                    fit: BoxFit.contain,
                  ),
                ),
                child: FutureBuilder(
                  future: fetchButtonState(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    List<Widget> children;

                    if (snapshot.hasData) {
                      var buttonState = snapshot.data;

                      children = [
                        const SizedBox.shrink(),
                        const SizedBox.shrink()
                      ];

                      if (buttonState[0]) {
                        // children[0] = SvgPicture.string(svgBox[0]);
                        children[0] = SvgPicture.asset(svgAsset[0]);
                      }
                      if (buttonState[1]) {
                        // children[1] = SvgPicture.string(svgBox[1]);
                        children[1] = SvgPicture.asset(svgAsset[1]);
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
