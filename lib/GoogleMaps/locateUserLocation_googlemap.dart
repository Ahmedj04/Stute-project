import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class LocateUserLocation_Google_maps_Screen extends StatefulWidget {

  var coordinatesid;
   LocateUserLocation_Google_maps_Screen({Key? key,required this.coordinatesid}) : super(key: key);

  @override
  State<LocateUserLocation_Google_maps_Screen> createState() => _LocateUserLocation_Google_maps_ScreenState();
}

class _LocateUserLocation_Google_maps_ScreenState extends State<LocateUserLocation_Google_maps_Screen> with SingleTickerProviderStateMixin {

  late GoogleMapController mapController;

  Map<String,Marker> _markers ={};

  User? user=FirebaseAuth.instance.currentUser;

  var latitude;
  var longitude;
  String address="";


  void initState() {
    print ('fetching userlocation details');
    getlocationDetail();
    super.initState();
  }

  Future<void> getlocationDetail() async{
    await FirebaseFirestore.instance.collection("Posts").doc(widget.coordinatesid).get().then((value) => {
      setState((){
        latitude=value['Latitude'];
        longitude=value['Longitude'];

      })
    });
  }
  

  // LatLng currentLocation = LatLng(latitude!, 74.809890);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          // target: currentLocation,
          target: LatLng(latitude,longitude),
          zoom: 14,
        ),
        onMapCreated: (controller){
          mapController = controller;
          // addMarker('test', currentLocation);
          addMarker('test', LatLng(latitude, longitude));
        },
        markers: _markers.values.toSet(),
      ),
    );
  }
  addMarker(String id, LatLng location) async{
    List<Placemark> placemark=  await placemarkFromCoordinates(latitude, longitude);
    setState(() {
      address=placemark.reversed.last.street.toString()+" "+placemark.reversed.last.locality.toString();
    });
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(
            // title: 'Title of the  place',
            // snippet: 'Some description of the place',
            title: 'Their location',
            snippet: address
        )

    );
    _markers[id]=marker;
    setState(() {

    });
  }
}
