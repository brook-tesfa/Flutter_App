import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_app/screens/home/components/pharmacy_model.dart';

// import <GoogleMaps/GoogleMaps/GMSMapView.h>

class PharmacyMap extends StatefulWidget {
  const PharmacyMap({Key? key}) : super(key: key);

  @override
  State<PharmacyMap> createState() => _PharmacyMapState();
}

class _PharmacyMapState extends State<PharmacyMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post_ = ModalRoute.of(context)!.settings.arguments as Pharmacy;
    double? latitude = post_.currentLatitude;
    double? long = post_.currentLongitude;
    int? distance = post_.distance;
    String? pharmacyName = post_.pharmacyName;
    Map<MarkerId, Marker> markers =
        <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

    void _add() {
      var markerIdVal = " distance is" + distance.toString();
      final MarkerId markerId = MarkerId(markerIdVal);

      // creating a new MARKERnce
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(latitude ?? 0, long ?? 0),
        infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
        onTap: () {
          // _onMarkerTapped(markerId);
        },
      );

      setState(() {
        // adding a new marker to map
        markers[markerId] = marker;
      });
    }

    _add();
    final CameraPosition _kLake = CameraPosition(
        bearing: 0,
        target: LatLng(latitude ?? 0, long ?? 0),
        tilt: 0,
        zoom: 19.151926040649414);
    Future<void> _goToTheLake() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 0,
          target: LatLng(latitude ?? 0, long ?? 0),
          tilt: 0,
          zoom: 19.151926040649414)));
    }

    return Scaffold(
      appBar: AppBar(
          title: Text("Distance left" + " " + post_.distance.toString())),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the Pharmacy!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
}
