import 'package:devlomatix/pages/base/BasePage.dart';
import 'package:devlomatix/pages/home/home.dart';
import 'package:devlomatix/providers/authProvider.dart';
import 'package:devlomatix/providers/userProvider.dart';
import 'package:devlomatix/services/authService.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePwd = true;

  final email = TextEditingController(text: 'admin@admin.com');
  final password = TextEditingController(text: 'password');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<AuthProvider>(builder: (context, provider, child) {
        return Container(
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Email Address",
                      prefixIcon: Icon(Icons.email),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      //errorText: "Please enter Email",
                      //suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg")
                    )),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    obscureText: hidePwd,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Your Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePwd = !hidePwd;
                            });
                          },
                          icon: Icon(
                            hidePwd ? Icons.visibility_off : Icons.visibility,
                            color: primaryColor.withOpacity(.4),
                          )),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    )),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 54,
                  width: MediaQuery.of(context).size.width * .95,
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (provider.clickable) {
                          provider.startLoad();
                          authProvider
                              .appLogin(email.text.trim(), password.text.trim())
                              .then((value) {
                            if (provider.loggedIn) {
                              userProvider.getUser(provider.authToken);
                              Navigator.popAndPushNamed(
                                  context, BasePage.routeName);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(value)),
                              );
                            }
                            provider.stoptLoad();
                          });
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: !provider.loading
                        ? primaryColor
                        : primaryColor.withOpacity(.5),
                    child: !provider.loading
                        ? const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        : Container(
                            height: 20,
                            width: 20,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white)),
                          ),
                  ),
                ),
              ],
            ),
          )),
        );
      }),
    );
  }
}
