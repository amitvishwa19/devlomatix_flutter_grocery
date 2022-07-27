import 'package:devlomatix/pages/auth/auth.dart';
import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/providers/userProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/constant.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:devlomatix/widgets/bottomNav.dart';
import 'package:devlomatix/widgets/circleAvatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  static String routeName = "/setting";
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              appProvider.changeBottomNav(0);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Settings'),
        titleSpacing: 0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          print('Setting page WillPopScope');

          //Navigator.pop(context);
          return true;
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              //User Info Card
              UserInfoCard(),

              //App Notification Setting
              InfoNavigationCard(
                info: 'App Notification Settings',
                icon: FontAwesomeIcons.bell,
                callback: () {},
              ),

              //Support and feedback
              InfoNavigationCard(
                info: 'Support & Feedback',
                icon: FontAwesomeIcons.info,
                callback: () {},
              ),

              //Tell a friend
              InfoNavigationCard(
                info: 'Tell a friend about DigiLearn',
                icon: FontAwesomeIcons.shareAlt,
                callback: () {
                  // share('https://flutter.dev/',
                  //     'Please install this application DigiLearn for online digital learning ');
                  //C:\Program Files\Android\Android Studio\jre\bin\keytool

                  //C:\Program Files\Android\Android Studio\jre\bin\keytool -genkey -v -keystore c:\Users\amitvishwa\key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
                },
              ),

              //Logout
              InfoNavigationCard(
                info: 'Logout',
                icon: FontAwesomeIcons.signOutAlt,
                callback: () {
                  SharePref.setString('token', '');
                  SharePref.setBool('loggedIn', false);
                  Navigator.popAndPushNamed(context, Auth.routeName);
                },
              ),

              const Spacer(),
              //App Info Area
              Container(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Strings.appIcon))),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Terms & Condition',
                            style: TextStyle(color: primaryColor),
                          ),
                          SizedBox(width: 4),
                          Text('|',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Text('Privacy Policy',
                              style: TextStyle(color: primaryColor)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Version ${Strings.appVersion}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
      //bottomNavigationBar: buidBottomNavBar(context)
    );
  }
}

class InfoNavigationCard extends StatelessWidget {
  //final Icon icon;
  final String info;
  final IconData icon;
  final void Function() callback;
  const InfoNavigationCard(
      {Key? key,
      required this.info,
      required this.icon,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: boxshadow,
      ),
      child: InkWell(
        onTap: callback,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 18,
                ),
                const SizedBox(width: 20),
                Text(info),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final String _initials = 'SA';
    final String _avatar = '';

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: boxshadow,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<UserProvider>(builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CAvatar(
                  text: _initials,
                  url: null,
                  radius: 25,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${value.user.firstname}, ${value.user.lastname}'),
                    Text('${value.user.email}'),
                    Text('${value.user.role}')
                  ],
                ),
                const Spacer(),
                IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.pen,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      appProvider.changeBottomNav(2);
                      print('Edit Profile');
                      //Navigator.pushNamed(context, EditProfile.routeName);
                      //Navigator.popAndPushNamed(context, EditProfile.routeName);
                    })
              ],
            );
          }),
        ),
      ),
    );
  }
}
