import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationModel {
  String name;
  int phoneNumber;
  String email;
  String? category;
  bool? hasAccess = false;

  RegistrationModel(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      this.category = "Ambulance Department",
      this.hasAccess});

  factory RegistrationModel.fromJson(Map<dynamic, dynamic> json) {
    return RegistrationModel(
      name: json['Name'],
      phoneNumber: int.parse(json['PhoneNumber']),
      email: json['Email'],
      category: json['Category'],
      hasAccess: json['HasAccess'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'Category': category,
      'hasAccess': hasAccess
    };
  }

  factory RegistrationModel.fromSnapshot(DocumentSnapshot snapshot) {
    final registration =
        RegistrationModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return registration;
  }
}
