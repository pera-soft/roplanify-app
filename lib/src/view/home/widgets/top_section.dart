import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/icon/fancybar_rotate_icon.dart';
import 'package:pera/src/view/home/service/location_service.dart';
import 'fancy_bar.dart';

class TopSection extends StatelessWidget with BaseSingleton {
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
                child: _drawerIcon(),
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
                child: _currentLocIcon(),
              ),
            ],
          )
        ],
      ),
    );
  }

  FancyBar _drawerIcon() {
    return FancyBar(
      height: 46,
      margin: const EdgeInsets.only(left: 20, top: 30),
      child: Icon(icons.menu, color: colors.black, size: 20),
    );
  }

  FancyBar _currentLocIcon() {
    return FancyBar(
      height: 46,
      margin: const EdgeInsets.only(right: 20, top: 30),
      child: Transform.rotate(
        angle: 3.14 / 4,
        child: FancyBarIcon(
            icons: icons.navigation, color: colors.black, size: 20),
      ),
    );
  }
}
