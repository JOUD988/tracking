/*
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking/google_maps_previous_project/location_services.txt';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //LocationServices().getPlaceId("Milan");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _originController = new TextEditingController();
  TextEditingController _destinationController = new TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;

  @override
  void initState() {
    super.initState();

    _setMarker(LatLng(33.488761, 36.339757));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(
            "Marker",
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdValue = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;
    _polygons.add(Polygon(
        polygonId: PolygonId(polygonIdValue),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
        strokeColor: Colors.green));
  }

  static final CameraPosition _kPresidentSquare = CameraPosition(
    target: LatLng(33.488761, 36.339757),
    zoom: 17.8,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
      ),
      body: Column(
        children: [
          Row(children: [
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    controller: _originController,
                    //textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: "Origin",
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  TextFormField(
                    controller: _destinationController,
                    //textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: "Destination",
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ],
              ),

            ),
            IconButton(
                onPressed: () async
                {
                  var place = await LocationServices().getPlace(_destinationController.text);


                },

                icon: Icon(Icons.search),

            ),
          ]),
          Expanded(
            child: GoogleMap(
              markers: _markers,
              polygons: _polygons,
              mapType: MapType.normal,
              initialCameraPosition: _kPresidentSquare,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) {
                setState(() {
                  polygonLatLngs.add(point);
                  _setPolygon();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));

    _setMarker(LatLng(lat, lng));
  }

  Future<void> goToPlaceByLatLng() async {
    final double lat = 33.511463;
    final double lng = 36.297999;

    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));
  }




}

*/
