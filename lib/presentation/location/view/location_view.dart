import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 8,
  );

  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('Our Location'),
        infoWindow: InfoWindow(title: 'welcome to Furniture App'),
        position: LatLng(30.033333, 31.233334),
    ),
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGoogle,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          getUserCurrentLocation().then((value) async {
            _markers.add(
                Marker(
                  markerId: const MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(
                    title: 'My Current Location',
                  ),
                )
            );

            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 8,
            );

            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {
            });
          });
        },
        child: const Icon(Icons.local_activity),
      ),
    );
  }
}