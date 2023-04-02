import 'package:flutter/material.dart';

abstract class AuthenticationBase {
  Future signInWithEmailAndPassword(
      BuildContext context, String email, String password);

  // create users with email and password
  Future createUserWithEmailAndPassword(BuildContext context, String email,
      String password, String name, int phoneNumber);

  // signout method
  Future signOut();

  // password reset method
  passwordReset(BuildContext context, String email);
}
