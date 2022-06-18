import 'package:devlomatix/pages/auth/auth.dart';
import 'package:devlomatix/pages/base/BasePage.dart';
import 'package:devlomatix/pages/home/home.dart';
import 'package:devlomatix/pages/onboard/onboard.dart';
import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/providers/authProvider.dart';
import 'package:devlomatix/providers/locationProvider.dart';
import 'package:devlomatix/providers/userProvider.dart';
import 'package:devlomatix/services/authService.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  static String routeName = "/splashscreen";
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    //appProvider.getLocation();
    Provider.of<LocationProvider>(context, listen: false).locationPermission();

    onBoarding(provider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Strings.splashBackground),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Row(
            // duration: Duration(seconds: 2),
            // height: 200,
            // width: 200,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage("assets/images/digilearn_logo.png"))),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(Strings.appIcon))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onBoarding(provider) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    //await SharePref.setBool('loggedIn', false);
    bool _onBoarding = await SharePref.getBool('onBoarding');
    bool _loggedIn = await SharePref.getBool('loggedIn');
    String token = await SharePref.getString('token');

    print('Onboarding: ' + _onBoarding.toString());
    print('Login: ' + _loggedIn.toString());

    //print(token);
    //print(_loggedIn.toString());

    if (!_onBoarding) {
      await Future.delayed(const Duration(seconds: 2), () {
        Navigator.popAndPushNamed(context, Onboard.routeName);
      });
    } else {
      if (_loggedIn) {
        print('App is logged in');
        authProvider.refresh(token).then((value) {
          if (value == 'unauthenticated.') {
            print(value);
            Navigator.popAndPushNamed(context, Auth.routeName);
          } else if (value == 'error') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(Strings.serverTimeOut.toString())),
            );
          } else {
            print('Token Refreshed');

            provider.getUser(value);

            SharePref.setString('token', value.toString());

            Future.delayed(const Duration(seconds: 2), () {
              //Navigator.popAndPushNamed(context, Home.routeName);
              Navigator.popAndPushNamed(context, BasePage.routeName);
            });
          }
        });
      } else {
        await Future.delayed(const Duration(seconds: 2), () {
          Navigator.popAndPushNamed(context, Auth.routeName);
        });
      }
    }
  }
}
