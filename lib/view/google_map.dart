import 'package:ambulance_staff/resource/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ambulance_staff/Controller/authentication_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

import '../resource/constants/service_constant.dart';

class MyMap extends StatefulWidget {
  final GeoPoint userLocation;
  final int caseID;
  MyMap({
    required this.userLocation,
    required this.caseID,
  });
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;

  @override
  Widget build(BuildContext context) {
    GeoPoint ambulanceLocation;
    GeoPoint fireBrigadeLocation;
    GeoPoint ambulanceStartLocation;
    final uid = Authentication().currentUser!.uid;
    final Stream<QuerySnapshot> _userHistory = FirebaseFirestore.instance
        .collection('AmbulanceDepartment')
        .where('caseID', isEqualTo: widget.caseID)
        .snapshots();

    // list
    List streamLocation;

    return StreamBuilder(
        stream: _userHistory,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // if (_added) {
          //   mymap(snapshot);
          // }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          //clearing the productsDocs list
          streamLocation = [];
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map historyData = document.data() as Map<String, dynamic>;
            streamLocation.add(historyData);
          }).toList();

          if (streamLocation[0]['ambulanceAllotedID'] != null) {}
          ambulanceLocation = streamLocation[0]['ambulanceLocation'] ??
              GeoPoint(27.6683, 85.3206);
          ambulanceStartLocation = ambulanceLocation;
          if (streamLocation[0]['fireBrigadeAllotedID'] != null) {}
          fireBrigadeLocation =
              streamLocation[0]['fireBrigade'] ?? GeoPoint(27.6, 85.3206);

          // polyline sections ************************************************

          // creating poly line
          Map<PolylineId, Polyline> polylinesMap = {};
          List<LatLng> polyLineCoordinates = [];

          _addPolyLine() {
            PolylineId id = PolylineId("Ambulance Route");
            Polyline polyline = Polyline(
                polylineId: id, color: Colors.red, points: polyLineCoordinates);
            polylinesMap[id] = polyline;
            setState(() {});
          }

          void getPolyPoints() async {
            PolylinePoints polylinePoints = PolylinePoints();
            PolylineResult result =
                await polylinePoints.getRouteBetweenCoordinates(
                    EmergencyServices.apivalue,
                    PointLatLng(
                      widget.userLocation.latitude,
                      widget.userLocation.longitude,
                    ),
                    PointLatLng(ambulanceLocation.latitude,
                        ambulanceLocation.longitude));

            if (result.points.isNotEmpty) {
              result.points.forEach((point) {
                polyLineCoordinates
                    .add(LatLng(point.latitude, point.longitude));
              });
              _addPolyLine();
            }
          }

          // getPolyPoints();
          print("map path value ${polylinesMap.values}");
          // *************************************************************************

          return Scaffold(
              appBar: AppBar(
                title: Text("MAP"),
                backgroundColor: AppColors.appBar_theme,
              ),
              body: GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: {
                  Marker(
                      position: LatLng(
                        widget.userLocation.latitude,
                        widget.userLocation.longitude,
                      ),
                      markerId: MarkerId('My Location'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen)),
                  Marker(
                      position: LatLng(ambulanceStartLocation.latitude,
                          ambulanceStartLocation.longitude),
                      markerId: MarkerId('Ambulance Position'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed)),
                  Marker(
                      position: LatLng(ambulanceLocation.latitude,
                          ambulanceLocation.longitude),
                      markerId: MarkerId('Ambulance Position'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed)),
                },
                polylines: Set<Polyline>.of(polylinesMap.values),
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget.userLocation.latitude,
                      widget.userLocation.longitude,
                    ),
                    zoom: 14.47),
                // onMapCreated: (GoogleMapController controller) async {
                //   setState(() {
                //     _controller = controller;
                //     _added = true;
                //   });
                // },
              ));
        });
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    List caseData = [];
    GeoPoint ambulanceLocation;
    snapshot.data!.docs.map((DocumentSnapshot document) {
      Map historyData = document.data() as Map<String, dynamic>;
      caseData.add(historyData);
    }).toList();

    ambulanceLocation = caseData[0]['ambulanceLocation'] as GeoPoint;
    await _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            // LatLng(ambulanceLocation.latitude, ambulanceLocation.longitude),
            LatLng(
          widget.userLocation.latitude,
          widget.userLocation.longitude,
        ),
        zoom: 14.47)));
  }
}
