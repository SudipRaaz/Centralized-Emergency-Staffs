import 'package:ambulance_staff/Controller/authentication_base.dart';
import 'package:ambulance_staff/Controller/authentication_functions.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../resource/components/buttons.dart';
import '../resource/constants/colors.dart';
import '../utilities/InfoDisplay/message.dart';
import '../utilities/routes/routes.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final ValueNotifier<bool> _obsecureText = ValueNotifier(true);

  // text controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // focusing pointer
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // initial age for registration
  double _initialAge = 18;
  // check box default value
  bool _checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        backgroundColor: AppColors.appBar_theme,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              // asset app logo display
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                child: Container(
                  width: width * .7,
                  height: height * .1,
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage('assets/app_logo.png')))
                ),
              ),

              // name form field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  focusNode: _nameFocusNode,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Name",
                    ),
                    prefixIcon: Icon(Icons.face_rounded),
                  ),
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_phoneFocusNode),
                ),
              ),

              // Phone Number textform field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  focusNode: _phoneFocusNode,
                  controller: _phoneController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Phone Number"),
                    prefixIcon: Icon(Icons.call_rounded),
                  ),
                  // requesting for password field focus
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_emailFocusNode),
                ),
              ),
              // email textform field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  focusNode: _emailFocusNode,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                  // requesting for password field focus
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_passwordFocusNode),
                ),
              ),

              // listining for obsecure icon tap
              ValueListenableBuilder(
                  valueListenable: _obsecureText,
                  builder: (context, obsecureText, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        focusNode: _passwordFocusNode,
                        controller: _passwordController,
                        obscureText: _obsecureText.value,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: const Text("Password"),
                            prefixIcon: const Icon(
                              Icons.lock_rounded,
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  // inverting obsecure password ontap
                                  _obsecureText.value = !_obsecureText.value;
                                },
                                child: _obsecureText.value
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined))),
                      ),
                    );
                  }),

              // agreement to term and conditions
              Row(
                children: [
                  Checkbox(
                      value: _checkBoxValue,
                      onChanged: ((value) {
                        setState(() {
                          _checkBoxValue = !_checkBoxValue;
                        });
                      })),
                  const Text('Agree to'),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RoutesName.termsAndConditions);
                      },
                      child: const Text('Term and Conditions'))
                ],
              ),
              SizedBox(
                height: height * .09,
              ),
              Buttons(
                text: "Register",
                onPress: () async {
                  // checking for name length
                  if (_nameController.text.isEmpty) {
                    Message.flushBarErrorMessage(context, "Enter a valid Name");
                  }

                  // checking for email format and length
                  else if (_emailController.text.isEmpty ||
                      !isEmail(_emailController.text)) {
                    Message.flushBarErrorMessage(
                        context, "Enter a valid Email address");
                  }
                  // checking for password length validation
                  else if (_passwordController.text.length < 6) {
                    Message.flushBarErrorMessage(
                        context, "Password must be at least 6 digits");
                    // checking if user agrees to terms and conditions of application
                  } else if (!_checkBoxValue) {
                    Message.flushBarErrorMessage(
                        context, "Accept to terms and conditions to proceed");
                  } else {
                    try {
                      // saving the data onto cloud firestore database
                      AuthenticationBase auth = Authentication();
                      auth.createUserWithEmailAndPassword(
                          context,
                          _emailController.text,
                          _passwordController.text,
                          _nameController.text,
                          int.parse(_phoneController.text));
                      Navigator.pop(context);
                      // catch any exceptions occured
                    } catch (e) {
                      Message.flushBarErrorMessage(context, e.toString());
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
