import 'package:ambulance_staff/view/Ambulance_Staff/ambulance_history.dart';
import 'package:ambulance_staff/view/FireBrigade_staff/fire_history.dart';
import 'package:ambulance_staff/view/Police_staff/police_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ambulance_staff/Controller/authentication_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/department_manager.dart';

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
              switch (departmentManager.department) {
                case "Ambulance Department":
                  return AmbulanceHistory();
                case "FireBrigade Department":
                  return FireHistory();
                case "Police Department":
                  return PoliceHistory();
              }
            }
            return const Center(
              child: Text('Error, No data'),
            );
          });
    });
  }
}
