import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../utils/widget_functions.dart';

class ProducePanel extends StatefulWidget {
  const ProducePanel({super.key});

  @override
  State<ProducePanel> createState() => _ProducePanelState();
}

class _ProducePanelState extends State<ProducePanel> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 25, top: 10),
            width: size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Produce Info',
                    style: themeData.textTheme.headline4,
                  ),
                  Center(
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                text: 'Section under development ',
                                style: themeData.textTheme.bodyMedium,
                                children: [
                              WidgetSpan(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: RiveAnimation.asset(
                                        'assets/images/cup_loader.riv',
                                        fit: BoxFit.fill),
                                  ),
                                  alignment: PlaceholderAlignment.middle)
                            ])),
                      ],
                    ),
                  ),
                  addVerticalSpace(10)
                ]),
          ),
        )
      ],
    );
  }
}
