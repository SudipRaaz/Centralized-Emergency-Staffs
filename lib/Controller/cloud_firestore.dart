import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ambulance_staff/Controller/cloud_firestore_base.dart';
import 'package:ambulance_staff/model/request_model.dart';
import 'package:flutter/material.dart';
import '../model/feedback_model.dart';
import '../model/registration_model.dart';

class MyCloudStore extends MyCloudStoreBase {
  @override
  Future registerUser(
      String? uid, String name, String email, int phoneNumber) async {
    // collection reference and doc id naming
    final docUser = FirebaseFirestore.instance.collection('Users').doc(uid);

    final user =
        RegistrationModel(name: name, phoneNumber: phoneNumber, email: email);
    // wating for doc set josn object on firebase
    await docUser.set(user.toJson());
  }

  @override
  Future requestService(
      int caseID,
      String uid,
      String name,
      String phoneNumber,
      bool ambulance,
      bool fireBrigade,
      bool police,
      String message,
      double latitude,
      double longitude,
      DateTime timestamp,
      String status) async {
    // document references
    final docReq = FirebaseFirestore.instance
        .collection('CustomerRequests')
        .doc('Requests')
        .collection(uid)
        .doc();

    // model fill
    final request = RequestModel(
        caseID: caseID,
        uid: uid,
        name: name,
        phoneNumber: phoneNumber,
        ambulanceService: ambulance,
        fireBrigadeService: fireBrigade,
        policeService: police,
        message: message,
        userLocation: GeoPoint(latitude, longitude),
        requestedAt: timestamp,
        status: status);

    // ambulance department
    final ambulanceDepartment =
        FirebaseFirestore.instance.collection('AmbulanceDepartment').doc();
    // fire brigade department
    final fireBrigadeDepartment =
        FirebaseFirestore.instance.collection('FireBrigadeDepartment').doc();
    // police department
    final policeDepartment =
        FirebaseFirestore.instance.collection('PoliceDepartment').doc();

    // checking for requested department and sending request to each department
    if (ambulance) {
      await ambulanceDepartment.set(request.toJson());
    }
    if (fireBrigade) {
      await fireBrigadeDepartment.set(request.toJson());
    }
    if (police) {
      await policeDepartment.set(request.toJson());
    }
    await docReq.set(request.toJson());
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
}
