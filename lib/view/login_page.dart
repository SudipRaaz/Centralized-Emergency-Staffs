import 'package:ambulance_staff/Controller/authentication_base.dart';
import 'package:ambulance_staff/Controller/authentication_functions.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../resource/components/buttons.dart';
import '../resource/constants/colors.dart';
import '../utilities/InfoDisplay/message.dart';
import '../utilities/routes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _obsecureText = ValueNotifier(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _obsecureText.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    // focus nodes disposed
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // setting available height and width
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Login'),
        centerTitle: true,
        backgroundColor: AppColors.appBar_theme,
      ),
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 30),
              // app logo decoration
              child: Container(
                  width: width * .7,
                  height: height * .3,
                  // color: Colors.amber,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.jpg')))),
            ),
            // decorating email text field
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
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_passwordFocusNode),
              ),
            ),
            // listening to value for obsecure text
            ValueListenableBuilder(
                valueListenable: _obsecureText,
                builder: (context, obsecureText, child) {
                  // decorating password text field
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
                                // toggling the obsecure value on tap
                                _obsecureText.value = !_obsecureText.value;
                              },
                              child: _obsecureText.value
                                  ? const Icon(Icons.visibility_off_outlined)
                                  : const Icon(Icons.visibility_outlined))),
                    ),
                  );
                }),
            // forgot password section
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Forgot Password?"),
                  TextButton(
                      onPressed: () {
                        // unfocusing the pointer
                        FocusManager.instance.primaryFocus!.unfocus();

                        // checking for valid email formating
                        if (_emailController.text.isEmpty ||
                            isEmail(_emailController.text)) {
                          try {
                            // reset mail
                            AuthenticationBase auth = Authentication();
                            auth.passwordReset(
                                context, _emailController.text.trim());
                            debugPrint(
                                "email : ${_emailController.text.trim()}");
                            // Message.flutterToast(
                            //     context, "Please Check your Mail box");
                          } catch (e) {
                            // show exception message
                            Message.flutterToast(context, e.toString());
                          }
                        } else {
                          // if email is empty or in invalid format display this message
                          Message.flutterToast(
                              context, 'Enter valid Email to reset Password');
                        }
                      },
                      child: const Text('Reset Password'))
                ],
              ),
            ),
            // gap space occupied
            SizedBox(
              height: height * .04,
            ),
            // widget button
            Buttons(
              text: "Login",
              onPress: () {
                if (_emailController.text.isEmpty ||
                    !isEmail(_emailController.text)) {
                  Message.flushBarErrorMessage(
                      context, "Enter a valid Email address");

                  // checking for valid password
                } else if (_passwordController.text.length < 6) {
                  Message.flushBarErrorMessage(
                      context, "Password must be at least 6 digits");
                } else {
                  // sign in using email and password
                  // requesting to method of auth class
                  AuthenticationBase auth = Authentication();
                  auth.signInWithEmailAndPassword(
                      context,
                      _emailController.text.trim(),
                      _passwordController.text.trim());
                }
              },
            ),

            // Sign Up section text and text button styling
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                    onPressed: () {
                      // navigating to register screen using routename
                      Navigator.pushNamed(context, RoutesName.register);
                    },
                    child: const Text('Sign Up'))
              ],
            )
          ],
        ),
      ]),
    );
  }
}
