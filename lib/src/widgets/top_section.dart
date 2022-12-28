import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pera/src/services/location_service.dart';
import 'fancy_bar.dart';

class TopSection extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  final Completer<GoogleMapController> controller;

  const TopSection(
      {super.key, required this.drawerKey, required this.controller});

  @override
  Widget build(BuildContext context) {
    LocationService ls = LocationService();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  drawerKey.currentState!.openDrawer();
                },
                child: const FancyBar(
                  height: 46,
                  margin: EdgeInsets.only(left: 20, top: 30),
                  child: Icon(Icons.menu, color: Colors.black, size: 20),
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  Position position = await ls.getCurrentLocation();
                  ls.goToCurrentLocation(controller, position);
                },
                child: FancyBar(
                  height: 46,
                  margin: const EdgeInsets.only(right: 20, top: 30),
                  child: Transform.rotate(
                    angle: 3.14 / 4,
                    child: const Icon(Icons.navigation,
                        color: Colors.black, size: 20),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
