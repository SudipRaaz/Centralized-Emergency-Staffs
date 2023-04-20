import 'package:ambulance_staff/Controller/authentication_functions.dart';
import 'package:ambulance_staff/resource/components/buttons.dart';
import 'package:ambulance_staff/resource/constants/colors.dart';
import 'package:ambulance_staff/view/google_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fire_dashboard extends StatefulWidget {
  const Fire_dashboard({super.key});

  @override
  State<Fire_dashboard> createState() => _Fire_dashboardState();
}

class _Fire_dashboardState extends State<Fire_dashboard> {
  // bool staffStatus;

  @override
  Widget build(BuildContext context) {
    // data stream references
    final Stream<QuerySnapshot> _userCase = FirebaseFirestore.instance
        .collection('FireBrigadeDepartment')
        .where('fireBrigadeAllotedID',
            isEqualTo: Authentication().currentUser!.uid)
        .where('Status', whereIn: ['Waiting', 'In Progress'])

        // .where('Status', isEqualTo: 'InProgress')
        .snapshots();

    // list
    List historyDocs;

    // media values
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Fire Brigade Department'),
          backgroundColor: AppColors.appBar_theme,
        ),
        body: StreamBuilder(
            stream: _userCase,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Loading"));
              }
              if (snapshot.hasData) {
                //clearing the productsDocs list
                historyDocs = [];

                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map historyData = document.data() as Map<String, dynamic>;
                  historyDocs.add(historyData);
                }).toList();

                return SizedBox(
                  height: _height,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      // formating timestamp from firebase data
                      Timestamp timestamp = historyDocs[index]['requestedAt'];
                      DateTime dateTime = timestamp.toDate();
                      var requestService = '';
                      var serviceAlloted = '';
                      if (historyDocs[index]['ambulanceService']) {
                        requestService = '\n      Ambulance Service';
                      }
                      if (historyDocs[index]['fireBrigadeService']) {
                        requestService =
                            '$requestService\n      Fire Brigade Service';
                      }
                      if (historyDocs[index]['policeService']) {
                        requestService =
                            '$requestService\n      Police Service';
                      }

                      // checking for service alloted
                      if (historyDocs[index]['ambulanceServiceAlloted']) {
                        serviceAlloted = '\n      Ambulance Service Alloted';
                      }
                      if (historyDocs[index]['fireBrigadeServiceAlloted']) {
                        serviceAlloted =
                            '$serviceAlloted\n       Fire Brigade Service Alloted';
                      }
                      if (historyDocs[index]['policeServiceAlloted']) {
                        serviceAlloted =
                            '$serviceAlloted\n       Police Service Alloted';
                      }

                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '''
Status :  ${historyDocs[index]['Status']}
Case ID: ${historyDocs[index]['caseID']}
Date: ${dateTime.year}/${dateTime.month}/${dateTime.day}        Time: ${dateTime.hour}:${dateTime.minute}:${dateTime.second}
Requeseted Service :  $requestService
Message : ${historyDocs[index]['message']}
Response:
$serviceAlloted
''',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Buttons(
                                        text: "View on Map",
                                        onPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      MyMap(
                                                        userLocation:
                                                            historyDocs[index][
                                                                'userLocation'],
                                                        caseID:
                                                            historyDocs[index]
                                                                ['caseID'],
                                                      )));
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: historyDocs.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
