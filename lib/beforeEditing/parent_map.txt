import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParentMap extends StatefulWidget {
  const ParentMap({Key? key}) : super(key: key);

  @override
  State<ParentMap> createState() => _ParentMapState();
}

class _ParentMapState extends State<ParentMap> {
  BitmapDescriptor? schoolIcon;
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Son On The Road \n Driver name: Ahmad"),
      ),
      body: Column(
        children: [

          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: {
                Marker(
                  markerId: MarkerId('مدرسة دار الحكمة'),
                  position: LatLng(33.509730, 36.296900),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange),
                ),
              },
              initialCameraPosition: CameraPosition(
                zoom: 16.0,
                target: LatLng(33.5136217, 36.3161035),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: () {}, child: Icon(Icons.bus_alert)),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _goToSchool();
                  });
                },
                child: Icon(Icons.school),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _goToSchool() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kSchool));
  }

  static final CameraPosition _kSchool = CameraPosition(
    bearing: 192.8334901395799,
    tilt: 59.440717697143555,
    target: LatLng(33.509730, 36.296900),
    zoom: 14.4746,
  );

  Future  <String> getSonStatus() async
  {

    //todo on on road arrived
    return "on road";


  }



}





/*
floatingActionButton: FloatingActionButton.extended(
onPressed: _goToTheLake,
label: Text('To the lake!'),
icon: Icon(Icons.directions_boat),
),
);
}

Future<void> _goToTheLake() async {
  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
}*/
