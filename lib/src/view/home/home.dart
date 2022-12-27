import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pera/src/services/LocationService.dart';
import 'package:pera/src/widgets/bottom_sheet/snapping_sheet.dart';
import 'package:pera/src/widgets/top_section.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final Completer<GoogleMapController> _controller = Completer();
  LocationService ls = LocationService();
  double deviceHeight = 0.0;
  double mapHeight = 0.0;

  static const CameraPosition _kIstanbul = CameraPosition(
    target: LatLng(41.0053215, 29.0121795),
    zoom: 10,
  );

  @override
  void initState() {
    super.initState();
    deviceHeight = window.physicalSize.longestSide / window.devicePixelRatio;
    ls.getCurrentLocation().then((value) {
      ls.goToCurrentLocation(_controller, value);
    });
  }

  setMapHeight(double height){
    if(mounted){
      setState(() {
        if(deviceHeight - height > deviceHeight / 2){
          mapHeight = deviceHeight - height;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        drawer: const Drawer(),
        body: Stack(
          children: [
            SizedBox(
              height: mapHeight,
              child: GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: _kIstanbul,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                zoomControlsEnabled: false,
                compassEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
              ),
            ),
            TopSection(
              drawerKey: _scaffoldKey,
              controller: _controller,
            ),
            SnappingSheetWidget(mapHeightCallback: setMapHeight),
          ],
        ),
      ),
    );
  }
}
