import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/providers/userProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/constant.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:devlomatix/widgets/circleAvatar.dart';
import 'package:devlomatix/widgets/homeAppbar.dart';
import 'package:devlomatix/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static String routeName = "/home";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: buildappBar(),
      body: Container(
        height: height,
        width: width,
        //duration: const Duration(microseconds: 100),
        decoration: const BoxDecoration(
            //color: Color.fromARGB(255, 64, 133, 59),
            image: DecorationImage(
                image: AssetImage(Strings.pageBackground), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Bottom Rounded top part
              Container(
                width: width,
                height: 60,
                decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    //Upcoming Event
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        transform: Matrix4.translationValues(0, -60, 0),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  boxShadow: boxshadow,
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  //mainAxisAlignment:MainAxisAlignment.start ,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: primaryColor,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.stream,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Upcoming Event',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '04.40 PM',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Status:Completed',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Container(
                                                child: const Text('6 Dec'),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    //Notice board
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: width,
                        transform: Matrix4.translationValues(0, -40, 0),
                        decoration: BoxDecoration(
                            boxShadow: boxshadow,
                            color: noticeBoard,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Notice Board',
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.left),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      color: primaryColor,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        FontAwesomeIcons.file,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  const Expanded(
                                    child: Text(
                                      'Access all important announcement,notices and circulars here',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Support and feedback
                    Container(
                      //height: 140,
                      width: width,
                      transform: Matrix4.translationValues(0, -20, 0),
                      decoration: BoxDecoration(
                          boxShadow: boxshadow,
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: Column(
                                children: const [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Support & Feedback',
                                        style: TextStyle(fontSize: 18),
                                        textAlign: TextAlign.left),
                                  ),
                                  SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Share your feedback and suggestions',
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.left),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Share.share(
                                    //     'check out my website https://example.com',
                                    //     subject: 'Look what I made!');
                                  },
                                  child: Container(
                                    child: Row(
                                      children: const [
                                        Icon(FontAwesomeIcons.envelope),
                                        SizedBox(width: 10),
                                        Text('Write to DigiLearn',
                                            style:
                                                TextStyle(color: primaryColor))
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 60,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    child: Row(
                                      children: const [
                                        Icon(FontAwesomeIcons.questionCircle),
                                        SizedBox(width: 10),
                                        Text('Support & Faq\'s',
                                            style:
                                                TextStyle(color: primaryColor)),
                                        SizedBox(width: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //Explore more
                    Container(
                      width: width,
                      transform: Matrix4.translationValues(0, 0, 0),
                      decoration: BoxDecoration(
                          boxShadow: boxshadow,
                          color: getMore,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(text: 'Get'),
                                        TextSpan(
                                            text: ' more',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(text: 'from'),
                                        TextSpan(
                                            text: ' Devlomatix',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigator.pushReplacementNamed(
                                          //     context, Explore.routeName);
                                        },
                                        child: Container(
                                          child: const Text(
                                            'Explore Now',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/splash_bg_2.png'))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      //bottomNavigationBar: buidBottomNavBar(context),
    );
  }
}
