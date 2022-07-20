import 'package:devlomatix/pages/auth/auth.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:flutter/material.dart';

class Onboard extends StatefulWidget {
  static String routeName = "/onboard";
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "title": "Welcome",
      "text":
          "Welcome to best online grocery store. Here you will find all the groceries at one place.",
      "image": "assets/images/grocery_onboard_1.png"
    },
    {
      "title": "Fresh Fruits & Vegetables",
      "text":
          "Buy farm fresh fruits & vegetables online at the best & affordable prices.",
      "image": "assets/images/grocery_onboard_2.png"
    },
    {
      "title": "Quick & Fast Delivery",
      "text":
          "We offers speedy delivery of your groceries, bathroom supplies, baby care products, pet care items, stationary, etc within 30minutes at your doorstep.",
      "image": "assets/images/grocery_onboard_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Strings.pageBackground))),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 750,
                  child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                          print(value);
                        });
                      },
                      itemCount: splashData.length,
                      itemBuilder: (context, index) => OnBoardContent(
                            appTitle: splashData[index]['title'] ?? '',
                            appSubtitle: splashData[index]['text'] ?? '',
                            image: splashData[index]['image'] ?? '',
                          )),
                )
              ],
            )
          ],
        ),
        bottomSheet: currentPage != splashData.length - 1
            ? Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(color: primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        await SharePref.setBool('onBoarding', true);
                        Navigator.pushReplacementNamed(context, Auth.routeName);
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            splashData.length, (index) => buildDots(index)),
                      ),
                    ),
                  ],
                ),
              )
            : InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Auth.routeName);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    decoration: const BoxDecoration(color: primaryColor),
                    child: const Text(
                      "Get Started now",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
              ),
      ),
    );
  }

  AnimatedContainer buildDots(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
          color: currentPage == index ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

class OnBoardContent extends StatelessWidget {
  final String appTitle, appSubtitle, image;
  const OnBoardContent(
      {Key? key,
      required this.appTitle,
      required this.appSubtitle,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 350,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(50),
          decoration:
              BoxDecoration(image: DecorationImage(image: AssetImage(image))),
        ),
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Text(
            appTitle,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Text(
            appSubtitle,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
