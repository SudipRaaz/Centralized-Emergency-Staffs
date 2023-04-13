import 'dart:developer';

import 'package:ambulance_staff/model/department_manager.dart';
import 'package:ambulance_staff/view/Ambulance_Staff/ambulance_dashboard.dart';
import 'package:ambulance_staff/view/FireBrigade_staff/fire_dashboard.dart';
import 'package:ambulance_staff/view/Police_staff/police_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ambulance_staff/Controller/authentication_functions.dart';
import 'package:ambulance_staff/resource/constants/service_constant.dart';
import 'package:ambulance_staff/utilities/InfoDisplay/dialogbox.dart';
import 'package:ambulance_staff/view/service_map_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:min_id/min_id.dart';
import 'package:provider/provider.dart';
import '../model/registration_model.dart';
import '../resource/constants/colors.dart';
import '../utilities/InfoDisplay/message.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController requestService = TextEditingController();
  bool checkAmbulance = false;
  bool checkFireBrigade = false;
  bool checkPolice = false;
  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    super.initState();
    // _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    // setting available height and width
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userID = Authentication().currentUser!.uid;
    final userProfile =
        FirebaseFirestore.instance.collection('Staffs').doc(userID).snapshots();

    return Consumer<DepartmentManager>(
        builder: (context, departmentManager, child) {
      return StreamBuilder(
          stream: userProfile,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error: " + snapshot.hasError.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return Text("Error: " + snapshot.error.toString());
            }
            if (snapshot.hasData) {
              // Authentication().signOut();
              // mapping json data to map
              Map<String, dynamic> data =
                  snapshot.data?.data() as Map<String, dynamic>;

              // setting the departmentname for provider
              departmentManager.updateDepartment(data['Category']);

              // redirecting user based upon their departments
              if (data['Category'] == 'Ambulance Department') {
                return Ambulance_dashboard();
              } else if (data['Category'] == 'FireBrigade Department') {
                return Fire_dashboard();
              } else if (data['Category'] == 'Police Department') {
                return PoliceDashboard();
              }

              return Center(
                child: Text('Contact your respective department'),
              );
            }
            return Text("Error loading");
          });
    });
  }

  // Scaffold Ambulance_dashboard(BuildContext context, Map<String, dynamic> data,
  //     double height, double width) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Centralized Emergency Services '),
  //         backgroundColor: AppColors.appBar_theme,
  //         actions: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 AuthenticationBase auth = Authentication();
  //                 auth.signOut();
  //               },
  //               style: ElevatedButton.styleFrom(
  //                   shape: const StadiumBorder(),
  //                   backgroundColor: AppColors.button_color,
  //                   foregroundColor: AppColors.blackColor),
  //               child: const Text('log Out'),
  //             ),
  //           ),
  //         ],
  //       ),
  //       body: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             SizedBox(
  //               height: 100,
  //               child: Padding(
  //                 padding:
  //                     const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Text("Panic Mode "),
  //                     ElevatedButton(
  //                       onPressed: () {},
  //                       style: ElevatedButton.styleFrom(
  //                           shape: const StadiumBorder(),
  //                           backgroundColor: AppColors.button_color,
  //                           foregroundColor: AppColors.blackColor),
  //                       child: const Text('Enable'),
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         Navigator.push(context, MaterialPageRoute(
  //                             builder: (BuildContext context) {
  //                           return ServicePage();
  //                         }));
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                           shape: const StadiumBorder(),
  //                           backgroundColor: AppColors.button_color,
  //                           foregroundColor: AppColors.blackColor),
  //                       child: const Text('Map'),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Text(
  //                 "$latitude   $longitude, ${data['Name']}, ${data['PhoneNumber']}"),
  //             // tile lists
  //             SizedBox(
  //               height: height,
  //               width: width,
  //               child: GridView.builder(
  //                   gridDelegate:
  //                       const SliverGridDelegateWithMaxCrossAxisExtent(
  //                     maxCrossAxisExtent: 200,
  //                     childAspectRatio: 3 / 3,
  //                   ),
  //                   itemCount: EmergencyServices.servicesTiles.length,
  //                   itemBuilder: (BuildContext context, index) {
  //                     return DashboardTile(
  //                       onPress: () {
  //                         _determinePosition();
  //                         switch (index) {
  //                           case 0:
  //                             // ambulance
  //                             ShowDialog().requestService(
  //                                 context,
  //                                 () {},
  //                                 "Ambulance",
  //                                 data['Name'],
  //                                 data['PhoneNumber'].toString(),
  //                                 latitude,
  //                                 longitude);
  //                             break;
  //                           // fire brigade
  //                           case 1:
  //                             ShowDialog().requestService(
  //                                 context,
  //                                 () {},
  //                                 "Fire Brigade",
  //                                 data['Name'],
  //                                 data['PhoneNumber'].toString(),
  //                                 latitude,
  //                                 longitude);
  //                             break;
  //                           // police
  //                           case 2:
  //                             ShowDialog().requestService(
  //                                 context,
  //                                 () {},
  //                                 "Police",
  //                                 data['Name'],
  //                                 data['PhoneNumber'].toString(),
  //                                 latitude,
  //                                 longitude);
  //                             break;
  //                           // Multiple service requests
  //                           case 3:
  //                             ShowDialog().requestMultipleService(
  //                                 context,
  //                                 data['Name'],
  //                                 data['PhoneNumber'].toString(),
  //                                 latitude,
  //                                 longitude);
  //                             break;
  //                           default:
  //                             Message.flushBarErrorMessage(
  //                                 context, "Service index is out of range");
  //                             break;
  //                         }
  //                       },
  //                       index: index,
  //                     );
  //                   }),
  //             ),
  //           ],
  //         ),
  //       ));
  // }
}

class DashboardTile extends StatelessWidget {
  final VoidCallback onPress;
  final int index;
  const DashboardTile({super.key, required this.onPress, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              border: Border.all(
                  color: Color.fromARGB(255, 54, 111, 244), width: 4),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, //New
                    blurRadius: 22.0,
                    offset: Offset(10, 5))
              ],
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(EmergencyServices.servicesTiles[index]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
