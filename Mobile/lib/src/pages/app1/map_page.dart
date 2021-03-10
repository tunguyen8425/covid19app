import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class MapPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _currentLocation;
  Iterable markers = [];
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    var _location = await Geolocator().getCurrentPosition();
    var url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + _location.latitude.toString() + ', ' + _location.longitude.toString() + '&radius=150000&type=hospital&key=AIzaSyA8q3xptu2kqEvpuLSPGS_S0chVSAomCqg';
    print(url);
    try {
      final response =
      await http.get(url);

      final int statusCode = response.statusCode;

      if (statusCode == 201 || statusCode == 200) {
        Map responseBody = json.decode(response.body);
        List results = responseBody["results"];

        Iterable _markers = Iterable.generate(10, (index) {
          Map result = results[index];
          Map location = result["geometry"]["location"];
          LatLng latLngMarker = LatLng(location["lat"], location["lng"]);

          return Marker(markerId: MarkerId("marker$index"),position: latLngMarker);
        });

        setState(() {
          markers = _markers;
        });
      } else {
        throw Exception('Error');
      }
    } catch(e) {
      print(e.toString());
    }
    setState(() {
      _currentLocation = LatLng(_location.latitude, _location.longitude);
    });
  }


  @override
  Widget build(BuildContext context) {
    return (_currentLocation != null)?Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation,
          zoom: 11.0,
        ),
        myLocationEnabled: true,
        markers: Set.from(
          markers,
        ),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    ):SizedBox();
  }
}