import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class DriverMap extends StatefulWidget {
  final userId;

  DriverMap(this.userId);

  @override
  State<DriverMap> createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  int sc = 1;
  int ss =22;
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  StreamSubscription<loc.LocationData>? _locationubscription;
  BitmapDescriptor? busIcon;
  Set<Marker> _markers = {};

  @override
  void initState() {
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10, 10)),
            'assets/images/school_bus.png')
        .then((onValue) {
      busIcon = onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("location").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (_added) myMap(snapshot);

            return GoogleMap(
              mapType: MapType.normal,
              markers: {
                Marker(
                  position: LatLng(
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.userId)["latitude"],
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.userId)["longitude"],
                  ),
                  markerId: MarkerId('id'),
                  icon: busIcon!,
                )
              },
              initialCameraPosition: CameraPosition(
                zoom: 16.0,
                target: LatLng(
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.userId)["latitude"],
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.userId)["longitude"],
                ),
              ),
              onMapCreated: (GoogleMapController controller) async {
                setState(() {
                  _controller = controller;
                  _added = true;
                });
              },
            );
          }),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                onPressed: () {
                  _getLocation();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_searching_sharp,
                      size: 24.0,
                    ),
                    Text('Current'), // <-- Text
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                onPressed: () {
                  _listenLocation();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.start,
                      size: 24.0,
                    ),
                    Text(' Start '), // <-- Text
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                onPressed: () {
                  _stopListening();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.stop,
                      size: 24.0,
                    ),
                    Text(' Stop '), // <-- Text
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();

      await FirebaseFirestore.instance.collection('location').doc('user1').set(
        {
          'latitude': _locationResult.latitude,
          'longitude': _locationResult.longitude,
          'name': "ahmad",
        },
        SetOptions(merge: true),
      );
      print(_locationResult.latitude);
      print(_locationResult.longitude);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationubscription?.cancel();
      setState(() {
        _locationubscription = null;
      });
    }).listen((loc.LocationData currentLocation) async {
      print(
          "latitude: ${currentLocation.latitude}, longitude: ${currentLocation.longitude}");

      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
        'name': "ahmad",
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationubscription?.cancel();
    setState(() {
      _locationubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted)
      print("Done");
    else if (status.isDenied)
      _requestPermission();
    else if (status.isPermanentlyDenied) openAppSettings();
  }

  Future<void> myMap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        snapshot.data!.docs
            .singleWhere((element) => element.id == widget.userId)["latitude"],
        snapshot.data!.docs
            .singleWhere((element) => element.id == widget.userId)["longitude"],
      ),
      zoom: 18,
    )));
  }
}
