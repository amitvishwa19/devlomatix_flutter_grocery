import 'package:devlomatix/pages/base/BasePage.dart';
import 'package:devlomatix/providers/userProvider.dart';
import 'package:devlomatix/services/authService.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/pref.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  bool clickable = true;
  bool hidePwd = true;
  bool hidecPwd = true;

  final email = TextEditingController(text: 'test_user@admin.com');
  final password = TextEditingController(text: 'password');
  final confirm_password = TextEditingController(text: 'password');
  final _formKey = GlobalKey<FormState>();

  register() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      if (clickable) {
        setState(() {
          _isLoading = true;
          clickable = false;
        });

        var data = {
          'email': email.text,
          'password': password.text,
          'confirm_password': confirm_password.text
        };

        AuthService authService = AuthService();
        authService.register(data).then((value) async {
          if (value.token != null) {
            await SharePref.setString('token', value.token.toString());
            await SharePref.setBool('loggedIn', true);
            provider.getUser(value.token.toString());

            setState(() {
              _isLoading = false;
              clickable = true;
            });

            Navigator.popAndPushNamed(context, BasePage.routeName);
          } else {
            setState(() {
              _isLoading = false;
              clickable = true;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Credentials')),
            );
          }
        });

        // await Future.delayed(const Duration(seconds: 2), () {
        //   setState(() {
        //     _isLoading = false;
        //     clickable = true;
        //   });
        // });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
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
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: password,
                      obscureText: hidePwd,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Password';
                        } else {
                          return null;
                        }
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
                    height: 20,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: confirm_password,
                      obscureText: hidecPwd,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter confirm Password';
                        } else if (value != password.text) {
                          return "Password and Confirm password not mached";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Confirm Your Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidecPwd = !hidecPwd;
                              });
                            },
                            icon: Icon(
                              hidecPwd
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: primaryColor.withOpacity(.4),
                            )),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 54,
                    width: MediaQuery.of(context).size.width * .95,
                    child: MaterialButton(
                      onPressed: () {
                        register();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: !_isLoading ? primaryColor : Colors.grey,
                      child: !_isLoading
                          ? const Text(
                              'Register',
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
              )),
        ),
      ),
    );
  }
}
