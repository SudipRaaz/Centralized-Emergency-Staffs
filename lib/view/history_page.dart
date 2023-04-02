import 'dart:developer';

import 'package:ambulance_staff/view/ambulance_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ambulance_staff/Controller/authentication_functions.dart';
import 'package:ambulance_staff/model/request_model.dart';
import 'package:ambulance_staff/resource/components/buttons.dart';
import 'package:ambulance_staff/view/google_map.dart';
import 'package:ambulance_staff/view/service_map_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/department_manager.dart';
import '../resource/constants/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = Authentication().currentUser!.uid;
    final Stream<QuerySnapshot> _userHistory = FirebaseFirestore.instance
        .collection('CustomerRequests')
        .doc('Requests')
        .collection(uid)
        .snapshots();

    // list
    List historyDocs;

    return Consumer<DepartmentManager>(
        builder: (context, departmentManager, child) {
      return StreamBuilder(
          stream: _userHistory,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }
            if (snapshot.hasData) {
              log('Department name: ${departmentManager.department}');

              switch (departmentManager.department) {
                case "Ambulance Department":
                  return AmbulanceHistory();
                case "FireBrigade Department":
                  return AmbulanceHistory();
                case "Police Department":
                  return AmbulanceHistory();
              }
            }
            return const Center(
              child: Text('Error, No data'),
            );
          });
    });
  }
}
