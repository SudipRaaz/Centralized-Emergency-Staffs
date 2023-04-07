import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ambulance_staff/Controller/cloud_firestore_base.dart';
import '../model/feedback_model.dart';
import '../model/registration_model.dart';

class MyCloudStore extends MyCloudStoreBase {
  @override
  Future registerUser(String? uid, RegistrationModel registerData) async {
    // collection reference and doc id naming
    final docUser = FirebaseFirestore.instance.collection('Staffs').doc(uid);

    // wating for doc set josn object on firebase
    await docUser.set(registerData.toJson());
  }

  @override
  Future updateUserActiveStatus(String? uid, bool status) async {
    // collection reference and doc id naming
    final docUser = FirebaseFirestore.instance.collection('Staffs').doc(uid);
    // active status
    final userStatus = {"ActiveStatus": status} as Map<String, bool>;
    ;
    // wating for doc set josn object on firebase
    await docUser.update(userStatus);
  }

  @override
  Future submitFeedback(int? rating, String? comment, String? report) async {
    // collection reference and doc id naming
    final docUser = FirebaseFirestore.instance.collection('CustomerCare').doc();

    final feeback =
        CustomerCare(rating: rating, comment: comment, report: report);
    // wating for doc set josn object on firebase
    await docUser.set(feeback.toJson());
  }

  @override
  Future updateGeoLocation(String? uid, GeoPoint location) async {
    // collection reference and doc id naming
    final docUser = FirebaseFirestore.instance.collection('Staffs').doc(uid);
    // active status
    final userStatus = {"Location": location};
    // wating for doc set josn object on firebase
    await docUser.update(userStatus as Map<String, GeoPoint>);
  }
}
