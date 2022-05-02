// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore: avoid_web_libraries_in_flutter, unused_import
import 'dart:html';

import 'dart:async';

// import './jquery.dart';
// import 'dart:ui';
// import 'dart:js' as js;

// import 'package:js/js.dart' as js;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';
// import 'package:path_drawing/path_drawing.dart';

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
  final svgBoxes = 'assets/images/box.svg';
  final svgBoxString = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="800" height="650">
    <rect class="grp1" x="200" y="100" width="150" height="150" display="block" fill="white" stroke="green" stroke-width="5" fill-opacity="0.0" stroke-opacity="0.9" />
    <rect class="grp2" x="400" y="150" width="200" height="150" display="block" fill="white" stroke="blue" stroke-width="5" fill-opacity="0.0" stroke-opacity="0.9" />
    <rect class="grp1" x="410" y="420" width="100" height="150" display="block" fill="white" stroke="green" stroke-width="5" fill-opacity="0.0" stroke-opacity="0.9" />
    <rect class="grp2" x="80" y="400" width="200" height="200" display="block" fill="white" stroke="blue" stroke-width="5" fill-opacity="0.0" stroke-opacity="0.9" />
</svg>''';
  final svgBlankString =
      '<svg xmlns="http://www.w3.org/2000/svg" width="800" height="650"></svg>';

  // final svgBoxesPicture = SvgPicture.asset('assets/images/box.svg');

  List<bool> buttonSel = [false, false];

  @override
  initState() {
    super.initState();
  }

  fetchButtonState() async {
    // print("fetching button state");
    return buttonSel;
  }

  Future<String> fetchSvgString(BuildContext context) async {
    print("fetching svg String");
    return await DefaultAssetBundle.of(context).loadString(svgBoxes);
  }

  editSVG(var buttonState, var svgString) {
    return svgString;
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
                // child: SvgPicture.asset(svgBoxes),
                child: FutureBuilder(
                    future: fetchButtonState(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      } else {
                        var buttonState = snapshot.data;

                        var svgString = svgBoxString;

                        // fetchSvgString(context).then((svgAsString) {
                        //   print(svgAsString);
                        //   svgString = svgAsString;
                        // });

                        final document = XmlDocument.parse(svgString);

                        for (var element in document.findAllElements('rect')) {
                          if (element.getAttribute("class") == "grp1") {
                            if (buttonState[0]) {
                              element.setAttribute("display", "block");
                            } else {
                              element.setAttribute("display", "none");
                            }
                          }
                          if (element.getAttribute("class") == "grp2") {
                            if (buttonState[1]) {
                              element.setAttribute("display", "block");
                            } else {
                              element.setAttribute("display", "none");
                            }
                          }
                        }

                        svgString = document.toString();

                        return SvgPicture.string(svgString);
                      }
                    }),
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
