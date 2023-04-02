import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  int caseID;
  // user ID
  String uid;
  String name;
  String phoneNumber;
  // user location
  GeoPoint userLocation;
  // requested service
  bool ambulanceService;
  bool fireBrigadeService;
  bool policeService;
  // message
  String message;
  // timestamp
  DateTime requestedAt;
  DateTime? allotedAt;
  // service alloted ID
  String? ambulanceAllotedID;
  GeoPoint? ambulanceLocation;

// firebrigade service
  String? fireBrigadeAllotedID;
  GeoPoint? fireBrigadeLocation;
  // police service
  String? policeAllotedID;
  GeoPoint? policeLocation;
  // service alloted bool
  bool ambulanceServiceAlloted;
  bool fireBrigadeServiceAlloted;
  bool policeServiceAlloted;

  // response
  String? responseMessage;

  // case status
  String? status;

  RequestModel(
      {required this.caseID,
      // user ID
      required this.uid,
      required this.name,
      required this.phoneNumber,
      // requested service
      required this.ambulanceService,
      required this.fireBrigadeService,
      required this.policeService,
      // user's message
      required this.message,
      // user location
      required this.userLocation,
      // timestamp
      required this.requestedAt,
      this.allotedAt,
      // service alloted
      this.ambulanceAllotedID,
      this.ambulanceLocation,
      // firebrigade service
      this.fireBrigadeAllotedID,
      this.fireBrigadeLocation,
      // police service
      this.policeAllotedID,
      this.policeLocation,
      // service alloted bool
      this.ambulanceServiceAlloted = false,
      this.fireBrigadeServiceAlloted = false,
      this.policeServiceAlloted = false,
      // message
      this.responseMessage,
      this.status});

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
        caseID: json['caseID'],
        uid: json["uid"] as String,
        name: json["name"] as String,
        phoneNumber: json["phoneNumber"] as String,
        userLocation: json["userLocation"],
        ambulanceService: json["ambulanceService"],
        fireBrigadeService: json["fireBrigadeService"],
        policeService: json["policeService"],
        message: json["message"],
        requestedAt: json["requestedAt"],
        allotedAt: json["allotedAt"],

        // ambulance service
        ambulanceAllotedID: json["ambulanceAllotedID"],
        ambulanceLocation: json["ambulanceLocation"],

        // fire brigade service
        fireBrigadeAllotedID: json["fireBrigadeAllotedID"],
        fireBrigadeLocation: json["fireBrigadeLocation"],

        // police service
        policeAllotedID: json["policeAllotedID"],
        policeLocation: json["policeLocation"],
        ambulanceServiceAlloted: json["ambulanceServiceAlloted"],
        fireBrigadeServiceAlloted: json["fireBrigadeServiceAlloted"],
        policeServiceAlloted: json["policeServiceAlloted"],
        responseMessage: json["responseMessage"],
        status: json["Status"] as String);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'caseID': caseID,
        'uid': uid,
        'name': name,
        'phoneNumber': phoneNumber,
        'ambulanceService': ambulanceService,
        'fireBrigadeService': fireBrigadeService,
        'policeService': policeService,
        'message': message,
        'userLocation': userLocation,
        'requestedAt': requestedAt,
        'allotedAt': allotedAt,

        // ambulance service
        'ambulanceAllotedID': ambulanceAllotedID,
        'ambulanceLocation': ambulanceLocation,

        // fire brigade service
        'fireBrigadeAllotedID': fireBrigadeAllotedID,
        'fireBrigadeLocation': fireBrigadeLocation,

        // police service
        'policeAllotedID': policeAllotedID,
        'policeLocation': policeLocation,

        // alloted service check bool
        'ambulanceServiceAlloted': ambulanceServiceAlloted,
        'fireBrigadeServiceAlloted': fireBrigadeServiceAlloted,
        'policeServiceAlloted': policeServiceAlloted,
        'responseMessage': responseMessage,
        'Status': status
      };

  factory RequestModel.fromSnapshot(DocumentSnapshot snapshot) {
    final requested =
        RequestModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return requested;
  }
}
