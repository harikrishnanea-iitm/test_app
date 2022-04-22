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
  final String svgStart = '<svg width="500" height="500">';
  final String svgEnd = '</svg>';

  final String svgBox0 =
      '<rect x="10" y="20" width="150" height="150" style="fill:white;stroke:green;stroke-width:5;fill-opacity:0.0;stroke-opacity:0.9" />';
  final String svgBox1 =
      '<rect  x="100" y="200" width="200" height="150" style="fill:white;stroke:blue;stroke-width:5;fill-opacity:0.0;stroke-opacity:0.9" />';

  String rawSvgbox = '<svg width="500" height="500"></svg>';

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
                    fit: BoxFit.none,
                  ), //
                ),
                child: SvgPicture.string(rawSvgbox),
                // child: SvgPicture.string(rawSvgbox),
              ),
              ToggleButtons(
                children: const [Icon(Icons.filter_1), Icon(Icons.filter_2)],
                onPressed: (int index) {
                  setState(() {
                    buttonSel[index] = !buttonSel[index];

                    String newSvg = "";
                    if (buttonSel[0]) {
                      newSvg += svgBox0;
                    }
                    if (buttonSel[1]) {
                      newSvg += svgBox1;
                    }

                    rawSvgbox = svgStart + newSvg + svgEnd;
                  });
                },
                isSelected: buttonSel,
              ),
            ]),
          )),
    );
  }
}
