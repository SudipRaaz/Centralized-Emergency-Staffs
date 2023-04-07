import 'dart:async';
import 'dart:developer';

import 'package:ambulance_staff/Controller/authentication_functions.dart';
import 'package:ambulance_staff/model/tab_manager.dart';
import 'package:ambulance_staff/resource/constants/pages_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'Controller/cloud_firestore.dart';
import 'Controller/cloud_firestore_base.dart';

class PageLayout extends StatefulWidget {
  const PageLayout({Key? key}) : super(key: key);

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  // to subscribe to Geo location
  // StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    liveLocation();
  }

  liveLocation() async {
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
    // Request location permissions and settings
    LocationAccuracy accuracy = LocationAccuracy.high;
    LocationSettings settings = LocationSettings(
      accuracy: accuracy,
      distanceFilter: 20,
    );

    // Listen to location updates
    Geolocator.getPositionStream(locationSettings: settings)
        .listen((Position position) {
      // updating user data
      MyCloudStoreBase obj = MyCloudStore();
      obj.updateGeoLocation(Authentication().currentUser!.uid,
          GeoPoint(position.latitude, position.longitude));

      log('position stream in page layout: ${position.latitude}  ${position.longitude}');
      // Update the database with the new position
      // This is where you can put your code to update the database
    });
  }

  @override
  Widget build(BuildContext context) {
    List pages = PageLists.pages;

    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
          body: pages[tabManager.selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabManager.selectedTab,
            //change the body based on the index of the bottom navigation tap
            onTap: (index) {
              // liveLocation();
              tabManager.goToTab(index);
            },
            fixedColor: Colors.black,
            backgroundColor: const Color.fromARGB(115, 248, 248, 248),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ));
    });
  }
}
