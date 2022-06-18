import 'dart:async';

import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/providers/locationProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SetLocation extends StatefulWidget {
  static String routeName = "/setlocation";
  const SetLocation({Key? key}) : super(key: key);

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng defaultLocation = const LatLng(28.4, 77.0);
  LatLng sourceLocation = const LatLng(28.4, 77.0);
  LatLng destinationLocation = const LatLng(28.4, 77.0);

  @override
  Widget build(BuildContext context) {
    LocationProvider location = Provider.of<LocationProvider>(context);

    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(location.lattitude, location.longitude),
      zoom: 18,
    );

    List<Marker> _markers = <Marker>[
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(location.lattitude, location.longitude),
        infoWindow: const InfoWindow(title: 'title of marker'),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: const Text('Set Your Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        zoomControlsEnabled: true,
        mapType: MapType.normal,
        mapToolbarEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_markers),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () async {
            location.getUserLocation();

            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(location.lattitude, location.longitude),
              zoom: 16,
            );

            final GoogleMapController controller = await _controller.future;

            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

            setState(() {});
          },
          child: Container(
            //margin: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(0),
            ),

            height: 50,
            width: double.infinity,
            child: const Center(
                child: Text('Set Current Location',
                    style: TextStyle(fontSize: 18, color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
