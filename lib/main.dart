import 'package:devlomatix/pages/splash/splash.dart';
import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/providers/authProvider.dart';
import 'package:devlomatix/providers/cartProvider.dart';
import 'package:devlomatix/providers/locationProvider.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/providers/userProvider.dart';
import 'package:devlomatix/providers/wishlistProvider.dart';
import 'package:devlomatix/utils/routes.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:devlomatix/widgets/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  // ignore: invalid_use_of_visible_for_testing_member
  //SharedPreferences.setMockInitialValues({});

  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  //FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => WishlistProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
      theme: theme(),
      initialRoute: Splash.routeName,
      routes: routes,
    );
  }
}
