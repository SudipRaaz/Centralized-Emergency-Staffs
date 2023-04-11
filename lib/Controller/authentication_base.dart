import 'package:ambulance_staff/model/registration_model.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationBase {
  Future signInWithEmailAndPassword(
      BuildContext context, String email, String password);

  // create users with email and password
  Future createUserWithEmailAndPassword(String name, String email,
      String password, int phoneNumber, String category);

  // signout method
  Future signOut();

  // password reset method
  passwordReset(BuildContext context, String email);
}
