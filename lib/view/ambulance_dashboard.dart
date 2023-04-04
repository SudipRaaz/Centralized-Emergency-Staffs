import 'dart:async';
import 'dart:developer';

import 'package:ambulance_staff/view/service_map_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../Controller/authentication_base.dart';
import '../Controller/authentication_functions.dart';
import '../resource/constants/colors.dart';

class Ambulance_dashboard extends StatefulWidget {
  const Ambulance_dashboard({super.key});

  @override
  State<Ambulance_dashboard> createState() => _Ambulance_dashboardState();
}

class _Ambulance_dashboardState extends State<Ambulance_dashboard> {
  var latitude;
  var longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ambulance Department'),
          backgroundColor: AppColors.appBar_theme,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  AuthenticationBase auth = Authentication();
                  auth.signOut();
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: AppColors.button_color,
                    foregroundColor: AppColors.blackColor),
                child: const Text('log Out'),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '$latitude  ' + '$longitude',
                style: TextStyle(fontSize: 40),
              ),
              Text(' New assigned Case'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return ServicePage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: AppColors.button_color,
                    foregroundColor: AppColors.blackColor),
                child: const Text('Map with polyline drawn'),
              ),
            ],
          ),
        ));
  }
}
