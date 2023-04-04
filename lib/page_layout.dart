import 'dart:async';
import 'dart:developer';

import 'package:ambulance_staff/model/tab_manager.dart';
import 'package:ambulance_staff/resource/constants/pages_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

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
    // Request location permissions and settings
    LocationPermission permission = await Geolocator.requestPermission();
    LocationAccuracy accuracy = LocationAccuracy.high;
    LocationSettings settings = LocationSettings(
      accuracy: accuracy,
      distanceFilter: 20,
    );

    // Listen to location updates
    Geolocator.getPositionStream(locationSettings: settings)
        .listen((Position position) {
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
