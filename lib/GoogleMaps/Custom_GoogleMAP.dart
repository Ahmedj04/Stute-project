import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:online_tutor_app/firebase_services.dart';

import '../Homepage.dart';

class CustomGoogleMap extends StatefulWidget {
  var currentPostid;

  CustomGoogleMap({Key? key, required this.currentPostid}) : super(key: key);

  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<CustomGoogleMap> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController controller;

  Location _location = Location();

  Map<String, Marker> _markers = {};

  User? user = FirebaseAuth.instance.currentUser;
  FirebaseServices services = FirebaseServices();

  var latitude;
  var longitude;
  String address = "";

  void _onMapCreated(GoogleMapController _value) async {
    controller = _value;

    _location.onLocationChanged.listen((event) {
      latitude = event.latitude;
      longitude = event.longitude;
      addMarker('text', LatLng(event.latitude!, event.longitude!));
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(event!.latitude!, event!.longitude!), zoom: 15)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                ),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                markers: _markers.values.toSet(),
              ),
              Positioned(
                bottom: 15,
                left: 50,
                right: 0,
                child: Container(
                  height: 50,
                  // width: double.infinity,
                  margin:
                      EdgeInsets.only(right: 60, left: 10, bottom: 40, top: 40),
                  child: MaterialButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'Saving your location');

                      // print(widget.currentPostid+" mae hun google map mae");

                      List<geo.Placemark> placemark = await geo
                          .placemarkFromCoordinates(latitude, longitude);
                      setState(() {
                        address = placemark.reversed.last.street.toString() +
                            "\n " +
                            placemark.reversed.last.locality.toString();
                      });

                      // print(address+" laayii jaghhhhhhh");

                      await _location.getLocation().then((value) => {
                            FirebaseFirestore.instance
                                .collection('Posts')
                                .doc(widget.currentPostid)
                                .update({
                              'Latitude': value.latitude,
                              'Longitude': value.longitude,
                              'Address': address,
                              // 'address':address,
                            }).whenComplete(() => {
                                      EasyLoading.showSuccess('Location Saved'),
                                      // Navigator.of(context).pop()
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              HomePage(),
                                        ),
                                        (Route<dynamic> route) => false,
                                      )
                                    }),
                            print(value.latitude),
                            print(value.longitude),
                          });
                    },
                    color: Colors.green,
                    child: Text(
                      "Set Location",
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addMarker(String id, LatLng location) async {
    List<geo.Placemark> placemark = await geo.placemarkFromCoordinates(
        location.latitude, location.longitude);
    setState(() {
      address = placemark.reversed.last.street.toString() +
          ", " +
          placemark.reversed.last.locality.toString();
    });
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(
            // title: 'Title of the  place',
            // snippet: 'Some description of the place',
            title: 'Your Current location',
            snippet: address));
    _markers[id] = marker;
    setState(() {});
  }
}
