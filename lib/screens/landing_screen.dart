import 'dart:async';
import 'dart:io';

import 'package:fh_mini_app/config/theme.dart';
import 'package:fh_mini_app/screens/help_guide.dart';
import 'package:fh_mini_app/screens/home_screen.dart';
import 'package:fh_mini_app/utils/constants.dart';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final url = 'http://192.168.4.1/LED';

  bool? hasLoaded = false;

  late Image image1;
  late Image image2;
  late Image image3;
  late Image image4;

  void fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    try {
      await get(Uri.parse(url)).timeout(const Duration(seconds: 1));
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      }
    } on TimeoutException catch (_) {
      debugPrint("Connection timeout");
      setState(() {
        connectionTimeout(context);
      });
    } on SocketException catch (_) {
      debugPrint("Other exception occured");
    } finally {
      hasLoaded = true;
    }
  }

  @override
  void initState() {
    super.initState();
    print('init state function ran');
    image1 = Image.asset('assets/images/0.gif');
    image2 = Image.asset('assets/images/1.png');
    image3 = Image.asset('assets/images/2.gif');
    image4 = Image.asset('assets/images/rainyOn.png');
    fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
    precacheImage(image3.image, context);
    precacheImage(image4.image, context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/leaf.jpg',
              height: size.height,
              fit: BoxFit.fitHeight,
            ),
            Center(
              child: Column(
                children: [
                  addVerticalSpace(50),
                  Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.14,
                  ),
                  Text(
                    'Welcome to the future of food',
                    style: themeData.textTheme.headline4,
                  ),
                  addVerticalSpace(30),
                  PodStatus(themeData: themeData, hasLoaded: hasLoaded!,),
                  addVerticalSpace(10),
                  spinkit(hasLoaded),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget spinkit(hasLoaded) {
    return hasLoaded
        ? const SizedBox.shrink()
        : const SpinKitWanderingCubes(
            color: Color.fromARGB(255, 14, 116, 23),
            size: 22,
          );
  }

  Future<dynamic> connectionTimeout(BuildContext context) {
    final TapGestureRecognizer gestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.of(context).push(_createRoute(HelpGuide()));
      };
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: RichText(
              text: TextSpan(
                  style: const TextStyle(color: brandBlack),
                  children: [
                    const TextSpan(
                        text:
                            'Connection could not be established to Mini. For further information on troubleshooting practices refer to our '),
                    TextSpan(
                        text: 'help guide',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 33, 82, 243),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600),
                        recognizer: gestureRecognizer),
                  ]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(_createRoute(HomePage()));
                },
                style: TextButton.styleFrom(
                    backgroundColor: myAppTheme.colorScheme.primary),
                child: const Text('Enter anyway',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        });
  }
}

class PodStatus extends StatelessWidget {
  const PodStatus({Key? key, required this.themeData, required this.hasLoaded})
      : super(key: key);

  final ThemeData themeData;
  final bool hasLoaded;

  @override
  Widget build(BuildContext context) {
    return hasLoaded ? const Text("couldn't connect :/",
            style: TextStyle(fontSize: 12, color: Colors.red)) :Text(
      'Connecting to your pod',
      style: themeData.textTheme.bodySmall,
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
