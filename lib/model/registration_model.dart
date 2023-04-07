import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegistrationModel {
  String name;
  int phoneNumber;
  String email;
  String category;
  bool hasAccess;
  bool activeStatus;
  GeoPoint location;

  RegistrationModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.category,
    this.hasAccess = false,
    this.activeStatus = false,
    this.location = const GeoPoint(27.6683, 85.3205),
  });

  factory RegistrationModel.fromJson(Map<dynamic, dynamic> json) {
    return RegistrationModel(
      name: json['Name'],
      phoneNumber: int.parse(json['PhoneNumber']),
      email: json['Email'],
      category: json['Category'],
      hasAccess: json['HasAccess'] as bool,
      activeStatus: json['ActiveStatus'] as bool,
      location: json['Location'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'Category': category,
      'HasAccess': hasAccess,
      'ActiveStatus': activeStatus,
      'Location': location
    };
  }

  factory RegistrationModel.fromSnapshot(DocumentSnapshot snapshot) {
    final registration =
        RegistrationModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return registration;
  }
  factory RegistrationModel.fromQuerySnapshot(
      AsyncSnapshot<DocumentSnapshot> snapshot) {
    final registration = RegistrationModel.fromJson(
        snapshot.data?.data() as Map<String, dynamic>);
    return registration;
  }
}
