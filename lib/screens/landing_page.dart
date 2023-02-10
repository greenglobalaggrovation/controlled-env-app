import 'package:fh_mini_app/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  var state = false;
  void toggleState() {
    state = !state;
  }

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

      return SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: size.height * 0.45,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 168, 92, 38),
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(120.0),
                        bottomRight: const Radius.circular(120.0),
                      ),
                    )),
                Column(
                  children: [
                    Text(
                      'EliteEco',
                      style: TextStyle(fontSize: 42),
                    ),
                    Text(
                      'Indoor farming made easy',
                      style: TextStyle(color: themeData.backgroundColor),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(3),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Authenticate()));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Get Started for Free ',
                            style: TextStyle(),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: ((size.height * 0.45) - (size.height * 0.07)),
              left: ((size.width * 0.5) - (size.height * 0.07)),
              child: FittedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(46.0),
                  child: Container(
                      color: Color.fromARGB(255, 61, 61, 61),
                      height: size.height * 0.14,
                      width: size.height * 0.14,
                      child: Center(
                        child: RiveAnimation.asset(
                          'assets/images/zack_animation.riv',
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
      ));
    }
  }

