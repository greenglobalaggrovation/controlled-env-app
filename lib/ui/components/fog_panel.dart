import 'dart:async';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

DatabaseReference DBref = FirebaseDatabase.instance.ref();
bool fogState = false;

void getFogSwitchStateFrmDB() async {
  final snapshot = await DBref.child('mini1/fog/pin12').get();
  snapshot.exists ? fogState = snapshot.value as bool : print("No fog data on db");
}

void updateFogSwitch(bool state) async {
  print("async func ran");
  await DBref.child("mini1/fog").update({
    "pin12": state,
  });
}

void readFoggerState() {}

class FogPanel extends StatefulWidget {
  const FogPanel({super.key});
  @override
  State<FogPanel> createState() => _FogPanelState();
}

class _FogPanelState extends State<FogPanel> {
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    getFogSwitchStateFrmDB();
  }

  void fogFetch(int index) async {
    String url = 'http://192.168.4.1/fog?fogCycle=${index}';
    debugPrint(url);
    try {
      Response fogResponse =
          await get(Uri.parse(url)).timeout(Duration(seconds: 3));
      print('Response from ESP : ${fogResponse.body}');
    } on TimeoutException catch (_) {
      print('Could not communicate');
    }
  }

  List<bool> isSelected = [true, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fog Cycles',
                    style: themeData.textTheme.headlineMedium,
                  ),
                  addVerticalSpace(30),
                  Text('Current fog rate : ${_value.toInt() * 5} %'),
                  Container(
                      child: Slider(
                    divisions: 10,
                    label: '${_value.toInt()} min',
                    activeColor: Theme.of(context).primaryColor,
                    thumbColor: Theme.of(context).colorScheme.secondary,
                    min: 0,
                    max: 10,
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                    onChangeEnd: (value) {
                      setState(() {
                        debugPrint('Value ends here : ${value.toInt()}');
                        fogFetch(value.toInt());
                      });
                    },
                  )),
                  SwitchListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(
                        'Make it rain',
                        style: themeData.textTheme.bodyMedium,
                      ),
                      value: fogState,
                      onChanged: (bool value) {
                        // setState(() {
                        //
                        //   fogState ? fogFetch(69) : fogFetch(96);
                        // });
                        setState(() {
                          updateFogSwitch(value);
                          fogState = value;
                        });
                      },
                      secondary: fogState
                          ? Image.asset(
                              'assets/images/rainyOn.png',
                              width: 30,
                            )
                          : Image.asset(
                              'assets/images/rainy.png',
                              width: 30,
                            )),
                  addVerticalSpace(20)
                ]),
          ),
        )
      ],
    );
  }
}
