import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pera/src/widgets/draggable_section.dart';
import 'package:pera/src/widgets/top_section.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final Completer<GoogleMapController> _controller = Completer();
  double top = 0.0;
  double initialTop = 0.0;

  static const CameraPosition _kIstanbul = CameraPosition(
    target: LatLng(41.0053215, 29.0121795),
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    final baseTop = MediaQuery.of(context).size.height * 0.9;
    const searchBarHeight = 54.0;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const Drawer(),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
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
            GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                final double scrollPos = details.globalPosition.dy;
                if (scrollPos < baseTop && scrollPos > searchBarHeight) {
                  setState(() {
                    top = scrollPos;
                  });
                }
              },
              child: DraggableSection(
                top: top == 0.0 ? baseTop : top,
                searchBarHeight: searchBarHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
