import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/registration_model.dart';

abstract class MyCloudStoreBase {
  // registering user data to database
  Future registerUser(String? uid, RegistrationModel registerData);

  // updating user active status
  Future updateUserActiveStatus(String? uid, bool status);

  // update Geo Location of user
  Future updateGeoLocation(String? uid, GeoPoint location);

  // submitting feedback to database
  Future submitFeedback(int? rating, String? comment, String? report);
}
