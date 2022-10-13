import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

import '../../utils/widget_functions.dart';
import 'components/pod_view.dart';
import 'header.dart';
import 'fog_panel.dart';

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

    return Column(
      children: [
        addVerticalSpace(25),
        Header(),
        addVerticalSpace(25),
        PodView(
          size: size,
          isSpin: spinType,
        ),
        addVerticalSpace(size.height * 0.13),
        ToggleButtons(
            borderRadius: BorderRadius.circular(12),
            fillColor: Color.fromARGB(255, 211, 211, 211),
            color: Theme.of(context).colorScheme.secondary,
            selectedColor: Theme.of(context).colorScheme.secondary,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Image.asset(
                    'assets/images/rotateAnticlockwise.png',
                    width: 32,
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Image.asset(
                    'assets/images/stop-button.png',
                    width: 32,
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
            })
      ],
    );
  }
}
