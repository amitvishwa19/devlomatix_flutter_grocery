import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/providers/userProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:devlomatix/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  static String routeName = "/profile";
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    //Form Controller
    final firstname = TextEditingController();
    final lastname = TextEditingController();
    final email = TextEditingController();
    final description = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              appProvider.changeBottomNav(0);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Profile'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Consumer<UserProvider>(builder: (context, provider, child) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //duration: const Duration(microseconds: 100),
            decoration: const BoxDecoration(
                //color: Color.fromARGB(255, 64, 133, 59),
                image: DecorationImage(
                    image: AssetImage(Strings.pageBackground),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Center(
                      child: Stack(children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: provider.profilePhoto(),
                      child: Text(
                          '${(provider.user.firstname.toString().substring(0, 1))}${(provider.user.lastname.toString().substring(0, 1))}',
                          style: const TextStyle(fontSize: 50)),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor)),
                            child: const Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        )),
                  ])),

                  const SizedBox(height: 35),

                  //User First Name
                  buildTextField('First Name', false, firstname, 1),

                  //User Last Name
                  buildTextField('Last Name', false, lastname, 1),

                  //About me section/textbox
                  buildTextField('About Me', false, description, 4),

                  SizedBox(
                    height: 54,
                    width: MediaQuery.of(context).size.width * .95,
                    child: MaterialButton(
                      onPressed: () {
                        //print(_avatar);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: !provider.loading
                          ? primaryColor
                          : primaryColor.withOpacity(.5),
                      child: !provider.loading
                          ? const Text(
                              'Update',
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
            ),
          );
        }),
      ),
      //bottomNavigationBar: buidBottomNavBar(context),
    );
  }

  //Image Picker dialog
  void _showPicker(context) {
    //UserProvider userProvider = Provider.of<UserProvider>(context);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Consumer<UserProvider>(builder: (context, provider, child) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      const Text('Profile Photo',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: primaryColor),
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //removeImage();
                                      Navigator.of(context).pop();
                                    }),
                              ),
                              const Text('Remove'),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: primaryColor),
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.photo_camera,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //userProvider.pickImage(ImageSource.camera);
                                      //provider.pickImage();
                                      provider.pickImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    }),
                              ),
                              const Text('Camera'),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: primaryColor),
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.photo_library,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      provider.pickImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    }),
                              ),
                              const Text('Gallery'),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  Widget buildTextField(String label, bool isPassword,
      TextEditingController controller, int maxLine) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        //minLines: 10,

        maxLines: maxLine,
        controller: controller,
        obscureText: isPassword ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPassword
                ? IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  )
                : null,
            //contentPadding: EdgeInsets.all(3),
            border: InputBorder.none,
            labelText: label,
            //floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }
}
