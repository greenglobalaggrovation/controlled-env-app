import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

class HelpGuide extends StatelessWidget {
  const HelpGuide({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(255, 216, 61, 230),
                  Color.fromARGB(255, 28, 63, 231)
                ])),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 220, 20, 220),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Container(
                        child: RichText(
                            text: TextSpan(
                                text: 'Troubleshoot Guide ',
                                style: themeData.textTheme.bodyMedium,
                                children: [
                              WidgetSpan(
                                  child: Image.asset(
                                    'assets/images/warning.png',
                                    width: 15,
                                  ),
                                  alignment: PlaceholderAlignment.middle)
                            ])),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Text('1.'),
                          title: Text(
                              'Check if the Pod is properly plugged in and the power source is working.'),
                        ),
                        ListTile(
                          leading: Text('2.'),
                          title: Text(
                              'Check if the Pod is properly plugged in and the power source is working.'),
                        ),
                        ListTile(
                          leading: Text('3.'),
                          title: Text(
                              'Check if the Pod is connected to the network.'),
                        ),
                        ListTile(
                          leading: Text('4.'),
                          title: Text(
                              'If the issue is not resolved by following the above steps, contact Green Global Aggrovation for further assistance.'),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(_createRoute(HomePage()));
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 202, 208),
                        ),
                        child: const Text(
                          'Enter anyway',
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        child: const Text('Exit app'),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 202, 208),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Route _createRoute(var screenName) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screenName,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}
