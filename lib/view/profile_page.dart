import 'dart:developer';
import 'package:ambulance_staff/Controller/cloud_firestore.dart';
import 'package:ambulance_staff/Controller/cloud_firestore_base.dart';
import 'package:ambulance_staff/resource/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ambulance_staff/Controller/authentication_functions.dart';
import 'package:ambulance_staff/utilities/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../Controller/authentication_base.dart';
import '../model/tab_manager.dart';
import '../resource/constants/colors.dart';
import '../resource/constants/sized_box.dart';
import '../utilities/InfoDisplay/dialogbox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late bool staffStatus;
  Position? geolocate;
  GeoPoint? userLocation;

  getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    geolocate = await Geolocator.getCurrentPosition();
    if (geolocate != null) {
      userLocation = GeoPoint(geolocate!.latitude, geolocate!.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final userID = Authentication().currentUser!.uid;
    final _userProfile =
        FirebaseFirestore.instance.collection('Staffs').doc(userID).get();
    List userDocs;

    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return FutureBuilder(
          future: _userProfile,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error: " + snapshot.hasError.toString());
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return Text("Error: " + snapshot.error.toString());
            }
            if (snapshot.hasData) {
              //clearing the productsDocs list
              userDocs = [];
              Map<String, dynamic> data =
                  snapshot.data?.data() as Map<String, dynamic>;

              // staff status
              staffStatus = data['ActiveStatus'] as bool;

              return Scaffold(
                appBar: AppBar(
                  title: const Text('Profile'),
                  backgroundColor: AppColors.appBar_theme,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          AuthenticationBase auth = Authentication();
                          auth.signOut();
                          tabManager.selectedTab = 0;
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
                body: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: _width,
                            // height: _height,
                            decoration: BoxDecoration(
                              color: AppColors.appBar_theme,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: ${data['Name']}",
                                    style:
                                        MyTextStyle().profile_page_credentials,
                                  ),
                                  Text(
                                    "Email: ${data['Email']}",
                                    style:
                                        MyTextStyle().profile_page_credentials,
                                  ),
                                  Text(
                                    "Department: ${data['Category']}",
                                    style:
                                        MyTextStyle().profile_page_credentials,
                                  ),
                                  Text(
                                    "Phone Number: ${data['PhoneNumber']}",
                                    style:
                                        MyTextStyle().profile_page_credentials,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        addVerticalSpace(40),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: ListTile(
                            selectedTileColor: AppColors.appBar_theme,
                            tileColor: Colors.blueAccent,
                            selected: true,
                            title: const Text(
                              'Active Status',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                            trailing: Transform.scale(
                              scale: 1.5,
                              child: Switch(
                                  activeTrackColor: Colors.greenAccent,
                                  inactiveTrackColor: Colors.redAccent,
                                  activeColor: Colors.white,
                                  value: staffStatus,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      staffStatus = newValue;

                                      getUserLocation();
                                      log('userLocation:  + ${userLocation?.latitude},  ${userLocation?.longitude}');

                                      if (userLocation?.latitude == null) {
                                        staffStatus = false;
                                      } else {
                                        // updating user data
                                        MyCloudStoreBase obj = MyCloudStore();
                                        obj.updateUserActiveStatus(
                                            userID, staffStatus);
                                        obj.updateGeoLocation(
                                            userID,
                                            GeoPoint(userLocation!.latitude,
                                                userLocation!.longitude));
                                      }
                                    });

                                    // obj.updateGeoLocation(userID, location)
                                  }),
                            ),
                          ),
                        ),
                        _featureTiles(
                          text: 'Feedback',
                          onPress: () {
                            return ShowDialog()
                                .showFeedbackForm(context, () {});
                          },
                        ),
                        _featureTiles(
                          text: 'User Guide',
                          onPress: () {
                            Navigator.pushNamed(context, RoutesName.userGuide);
                          },
                        ),
                        _featureTiles(
                          text: 'Report Bug',
                          onPress: () {
                            ShowDialog().reportBug(context, () {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          });
    });
  }
}

class _featureTiles extends StatelessWidget {
  String text;
  VoidCallback onPress;
  _featureTiles({required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: onPress,
        child: ListTile(
          selectedTileColor: AppColors.appBar_theme,
          tileColor: Colors.blueAccent,
          selected: true,
          title: Text(
            text,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
