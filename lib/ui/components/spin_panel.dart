import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../utils/widget_functions.dart';
import 'pod_view.dart';
import 'header.dart';

bool podSpin = true;
int spinType = 2;

class SpinPanel extends StatefulWidget {
  const SpinPanel({super.key});

  @override
  State<SpinPanel> createState() => _SpinPanelState();
}

class _SpinPanelState extends State<SpinPanel> {
  var buttonsSelected = [true, false, false];

  void makeGetReq(int index) async {
    try {
      Response response = await get(Uri.parse('http://192.168.4.1/spin/$index'))
          .timeout(Duration(seconds: 3));
      debugPrint(response.body);
    } on TimeoutException catch (_) {
      debugPrint('Connection timeout');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final ThemeData themeData = Theme.of(context);
    return Column(
      children: [
       
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 25, top: 10),
            width: size.width,
            //color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spin it up!',
                  style: themeData.textTheme.headline4,
                ),
                Center(
                  child: ToggleButtons(
                      borderRadius: BorderRadius.circular(12),
                      fillColor: Color.fromARGB(255, 211, 211, 211),
                      highlightColor: Theme.of(context).colorScheme.secondary,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 6),
                            child: Image.asset(
                              'assets/images/rotateAnticlockwise.png',
                              width: 32,
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 6),
                            child: Image.asset(
                              'assets/images/stop-button.png',
                              width: 32,
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 6),
                            child: Image.asset(
                              'assets/images/rotateClockwise.png',
                              width: 32,
                            )),
                      ],
                      isSelected: buttonsSelected,
                      onPressed: (int index) {
                        setState(() {
                          makeGetReq(index);
                          debugPrint('Fog fetch func called');
                          spinType = index;
                          debugPrint('Pod spinning in $spinType');
                          for (int i = 0; i < buttonsSelected.length; i++) {
                            buttonsSelected[i] = i == index;
                          }
                        });
                      }),
                ),
                addVerticalSpace(10)
              ],
            ),
          ),
        )
      ],
    );
  }
}
