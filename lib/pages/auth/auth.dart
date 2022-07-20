import 'package:devlomatix/pages/auth/login.dart';
import 'package:devlomatix/pages/auth/register.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  static String routeName = "/auth";
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  int _pageState = 0;

  double loginXOffset = 0;
  double loginYOffset = 0;

  double registerXOffset = 0;
  double registerYOffset = 0;

  double windowHeight = 0;
  double windowWidth = 0;

  var _registerStackColor;

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    switch (_pageState) {
      case 0:
        loginYOffset = 220;
        registerXOffset = 20;
        _registerStackColor = primaryColor.withOpacity(1);
        break;
      case 1:
        loginYOffset = windowHeight;
        registerXOffset = 0;
        _registerStackColor = Colors.white;
        break;
    }

    return Scaffold(
        body: Stack(
      children: [
        //MAin Background stack
        backgroundStack(context),

        //Register stack
        registerStack(context),

        //Login Stack
        loginStack(context),
      ],
    ));
  }

  //Background stack
  AnimatedContainer backgroundStack(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      color: primaryColor,
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    child: const Text(
                      Strings.appTitle,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: const Text(
                      Strings.introTitle,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  //Login Stack Animated Container
  AnimatedContainer loginStack(BuildContext context) {
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 600),
      transform: Matrix4.translationValues(0, loginYOffset, 1),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ),
                    Text(
                      "Login with your email and password or continue with social login",
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            Login(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have Account ?"),
                InkWell(
                  onTap: () {
                    setState(() {
                      //print(_pageState);
                      _pageState = 1;
                    });
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //Register stack
  AnimatedContainer registerStack(BuildContext context) {
    return AnimatedContainer(
      height: windowHeight,
      padding: const EdgeInsets.all(20),
      width: _pageState == 1 ? windowWidth : windowWidth - 40,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 2000),
      transform: Matrix4.translationValues(registerXOffset, 200, 1),
      decoration: BoxDecoration(
          color: _registerStackColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Create New Account",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ),
                  ],
                )),
            const Register(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have Account ?"),
                InkWell(
                  onTap: () {
                    setState(() {
                      print(_pageState);
                      _pageState = 0;
                    });
                  },
                  child: const Text(
                    "SignIn",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
