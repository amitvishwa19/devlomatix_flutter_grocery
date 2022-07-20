import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  static String routeName = "/addAddress";
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  final house = TextEditingController();
  final locality = TextEditingController();
  final landmark = TextEditingController();
  final optional = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final pincode = TextEditingController();

  addAdress() {
    if (_formKey.currentState!.validate()) {
      print('Address will be added');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                ),
                InputField(
                  label: 'Locality',
                  hint: 'Enter locality',
                  error: 'Locality is required',
                  controler: locality,
                  validate: false,
                ),
                InputField(
                  label: 'Landmark',
                  hint: 'Enter Landmark',
                  error: 'Landmark is required',
                  controler: landmark,
                  validate: true,
                ),
                InputField(
                  label: 'Optional details',
                  hint: 'Enter Optional',
                  error: '',
                  controler: optional,
                  validate: false,
                ),
                InputField(
                  label: 'City',
                  hint: 'Enter City',
                  error: 'City is required',
                  controler: city,
                  validate: true,
                ),
                InputField(
                  label: 'State',
                  hint: 'Enter State',
                  error: 'State is required',
                  controler: state,
                  validate: true,
                ),
                InputField(
                  label: 'Pincode',
                  hint: 'Enter Pincode',
                  error: 'Pincode is required',
                  controler: pincode,
                  validate: true,
                ),
              ],
            )),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: InkWell(
          onTap: () {
            addAdress();
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(
              child: Text(
                'Add Address',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
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

  InputField({
    Key? key,
    required this.label,
    required this.hint,
    required this.error,
    required this.controler,
    required this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: TextFormField(
          keyboardType: TextInputType.emailAddress,
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
