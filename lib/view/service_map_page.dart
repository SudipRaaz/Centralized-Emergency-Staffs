import 'package:ambulance_staff/resource/constants/colors.dart';
import 'package:ambulance_staff/resource/constants/constant_values.dart';
import 'package:ambulance_staff/view/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  GoogleMapController? _controller;
  final List<Marker> _markers = [];

  // locations
  late LatLng sourceLocation = LatLng(27.6772194524, 85.3168201447);
  LatLng destinationLocation = LatLng(27.6841741279, 85.3193950653);

  @override
  void initState() {
    super.initState();

    // Add markers for vehicles to the list of markers
    _markers.add(
      Marker(
        markerId: const MarkerId('Source'),
        position: sourceLocation,
        infoWindow: const InfoWindow(
          title: 'Vehicle 1',
          snippet: 'Vehicle Type: Sedan',
        ),
        onTap: () {
          // Show further details about the vehicle when tapped
        },
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('Destination'),
        position: destinationLocation,
        infoWindow: const InfoWindow(
          title: 'Vehicle 2',
          snippet: 'Vehicle Type: SUV',
        ),
        onTap: () {
          // Show further details about the vehicle when tapped
        },
      ),
    );
    getPolyPoints();
  }

  Map<PolylineId, Polyline> polylinesMap = {};
  List<LatLng> polyLineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        EmergencyServices.apivalue,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      _addPolyLine();
    }
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polyLineCoordinates);
    polylinesMap[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardPage>(
        builder: (context, dashboardProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Ambulance Services'),
          backgroundColor: AppColors.appBar_theme,
        ),
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          myLocationEnabled: true,
          polylines: Set<Polyline>.of(polylinesMap.values),
          initialCameraPosition: const CameraPosition(
            target: LatLng(27.689875, 85.319178),
            zoom: 14.0,
          ),
          markers: Set.from(_markers),
        ),
      );
    });
  }
}
