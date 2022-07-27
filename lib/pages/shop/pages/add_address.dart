import 'dart:convert';

import 'package:devlomatix/providers/checkoutProvider.dart';
import 'package:devlomatix/providers/userProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  static String routeName = "/addAddress";
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  final house = TextEditingController(text: '202');
  final locality = TextEditingController(text: 'Rajeshwer Planet');
  final landmark = TextEditingController(text: 'Near super market');
  final optional = TextEditingController();
  final city = TextEditingController(text: 'Vadodara');
  final state = TextEditingController(text: 'Gujarat');
  final pincode = TextEditingController(text: '390022');
  final mobile = TextEditingController(text: '9712340450');

  bool loading = false;

  String addType = 'home';

  @override
  Widget build(BuildContext context) {
    //UserProvider userProvider = Provider.of<UserProvider>(context);
    CheckoutProvider checkoutProvider = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputField(
                  label: 'House',
                  hint: 'Enter house number',
                  error: 'Enter house number',
                  controler: house,
                  validate: true,
                  inputType: TextInputType.name,
                ),
                InputField(
                  label: 'Locality',
                  hint: 'Enter locality',
                  error: 'Locality is required',
                  controler: locality,
                  validate: false,
                  inputType: TextInputType.name,
                ),
                InputField(
                  label: 'Landmark',
                  hint: 'Enter Landmark',
                  error: 'Landmark is required',
                  controler: landmark,
                  validate: true,
                  inputType: TextInputType.name,
                ),
                InputField(
                  label: 'Optional details',
                  hint: 'Enter Optional',
                  error: '',
                  controler: optional,
                  validate: false,
                  inputType: TextInputType.name,
                ),
                InputField(
                  label: 'City',
                  hint: 'Enter City',
                  error: 'City is required',
                  controler: city,
                  validate: true,
                  inputType: TextInputType.name,
                ),
                InputField(
                  label: 'State',
                  hint: 'Enter State',
                  error: 'State is required',
                  controler: state,
                  validate: true,
                  inputType: TextInputType.name,
                ),
                InputField(
                  label: 'Pincode',
                  hint: 'Enter Pincode',
                  error: 'Pincode is required',
                  controler: pincode,
                  validate: true,
                  inputType: TextInputType.number,
                ),
                InputField(
                  label: 'Mobile',
                  hint: 'Enter contact number',
                  error: 'Mobile number is required',
                  controler: mobile,
                  validate: true,
                  inputType: TextInputType.number,
                ),
                const ListTile(
                  title: Text('Address Type'),
                ),
                RadioListTile(
                  title: const Text('Home'),
                  value: 'home',
                  groupValue: addType,
                  onChanged: (e) {
                    setState(() {
                      addType = 'home';
                    });
                  },
                  secondary: const Icon(
                    Icons.home,
                    color: primaryColor,
                  ),
                ),
                RadioListTile(
                  title: const Text('Office'),
                  value: 'work',
                  groupValue: addType,
                  onChanged: (e) {
                    setState(() {
                      addType = 'work';
                    });
                  },
                  secondary: const Icon(
                    Icons.work,
                    color: primaryColor,
                  ),
                ),
                RadioListTile(
                  title: const Text('Other'),
                  value: 'other',
                  groupValue: addType,
                  onChanged: (value) {
                    setState(() {
                      addType = 'other';
                    });
                  },
                  secondary: const Icon(
                    Icons.devices_other,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  height: 80,
                  child: SizedBox(
                    height: 54,
                    width: MediaQuery.of(context).size.width * .95,
                    child: MaterialButton(
                      onPressed: () {
                        var data = {
                          'house': house.text,
                          'locality': locality.text,
                          'landmark': landmark.text,
                          'optional': optional.text,
                          'city': city.text,
                          'state': state.text,
                          'pincode': pincode.text,
                          'mobile': mobile.text,
                          'type': addType
                        };

                        if (_formKey.currentState!.validate()) {
                          if (!loading) {
                            setState(() {
                              loading = true;
                            });

                            checkoutProvider.addAddress(data).then((value) {
                              print(value);

                              if (value == 'success') {
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pop(context);
                              }
                            });
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color:
                          loading ? primaryColor.withOpacity(.5) : primaryColor,
                      child: !loading
                          ? const Text(
                              'Add Address',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          : const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white)),
                            ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final String error;
  final bool validate;
  final TextEditingController controler;
  final TextInputType inputType;

  InputField({
    Key? key,
    required this.label,
    required this.hint,
    required this.error,
    required this.controler,
    required this.validate,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: TextFormField(
          keyboardType: inputType,
          controller: controler,
          validator: (value) {
            if (validate) {
              if (value == null || value.isEmpty) {
                return error;
              }
              return null;
            }
          },
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          )),
    );
  }
}
