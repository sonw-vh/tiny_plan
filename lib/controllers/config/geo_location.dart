import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiny_plan/controllers/services/auth.dart';
import 'package:tiny_plan/controllers/services/database.dart';
import 'package:tiny_plan/controllers/services/geo_locator_service.dart';

class Geo extends StatefulWidget {
  final Position initialPosition;
  final Database database;

  Geo(this.initialPosition, this.database);

  @override
  State<StatefulWidget> createState() => _GeoState();
}

class _GeoState extends State<Geo> {
  final Completer<GoogleMapController> _controller = Completer();

  late User _currentUser;
  var imageData;
  List<Marker> allMarkers = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var childLocationsList = [];

  @override
  void initState() {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final geoService = Provider.of<GeoLocatorService>(context, listen: false);
    _currentUser = auth.currentUser!;
    geoService.getCurrentLocation.listen((position) {
      centerScreen(position);
    });
    super.initState();
  }

  Future<Uint8List> getChildMarkerImage(Map<String, dynamic> data) async {
    var bytes =
        (await NetworkAssetBundle(Uri.parse(data['image'])).load(data['image']))
            .buffer
            .asUint8List();

    return bytes;
  }

  //TODO:Make function async
  Future<List<Marker>> initMarker(Map<String, dynamic> data) async {
    print('--------------- data -------------');
    print(data['id']);
    print(data['position']?.latitude);
    print(data['position']?.longitude);
    allMarkers.add(Marker(
      infoWindow: InfoWindow(
          title: data['id'],
          snippet: data['name'],
          onTap: () {
            print('Tapped');
          }),
      markerId: MarkerId(data['id']),
      //TODO:Implement child image as marker
      //icon: BitmapDescriptor.fromBytes(imageData),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      draggable: false,
      onTap: () {
        print('Marker Tapped');
      },
      position: LatLng(data['position'].latitude, data['position'].longitude),
    ));
    print(allMarkers);
    return allMarkers;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.initialPosition.latitude,
                  widget.initialPosition.longitude),
              zoom: 15),
          mapType: MapType.normal,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            setState(() {
              markers[MarkerId(allMarkers.first.markerId.value)] =
                  allMarkers.first;
            });
          },
          markers: Set<Marker>.of(allMarkers),
        ),
      ),
    );
  }

  Future<void> centerScreen(Position position) async {
    final controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 16.0)));
  }
}
