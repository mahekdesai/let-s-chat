import 'package:flutter/material.dart';
import 'package:letschat/screens/login_screen.dart';
import 'package:letschat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:letschat/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
  static const String id = 'WelcomeScreen';
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animation1;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    animation =
        ColorTween(begin: Colors.cyan, end: Colors.white).animate(controller);
    animation1 = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: animation1.value * 60,
                    ),
                  ),
                  AnimatedTextKit(
                    repeatForever: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Lets Chat',
                        speed: Duration(milliseconds: 95),
                        textStyle: TextStyle(
                          fontSize: 45.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            myButton(
                buttonColor: Colors.lightBlueAccent,
                buttonText: 'Log In',
                onPress: (){
                  Navigator.pushNamed(context, LoginScreen.id);
                },
            ),
            myButton(
              buttonColor: Colors.blueAccent,
              buttonText: 'Register',
              onPress: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
