import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pera/src/view/home/model/optimized_route.dart';
import 'package:pera/src/view/home/service/location_service.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/snapping_sheet.dart';
import 'package:pera/src/view/home/widgets/top_section.dart';
import 'dart:ui' as ui;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final Completer<GoogleMapController> _controller = Completer();
  ValueNotifier<OptimizedRoute?> routes = ValueNotifier(null);
  Set<Marker> markers = {};
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
    mapHeight = deviceHeight;
    ls.getCurrentLocation().then((value) {
      ls.goToCurrentLocation(_controller, value);
    });

    routes.addListener(() {
      updateMarkers(routes.value);
    });
  }

  setMapHeight(double height) {
    setState(() {
      if (deviceHeight - height > deviceHeight / 2) {
        mapHeight = deviceHeight - height;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        drawer: _drawer(),
        body: Stack(
          children: [
            _sizedBoxMap(),
            _topSection(),
            SnappingSheetWidget(
                mapHeightCallback: setMapHeight, routes: routes),
          ],
        ),
      ),
    );
  }

  Drawer _drawer() => const Drawer();

  TopSection _topSection() {
    return TopSection(
      drawerKey: _scaffoldKey,
      controller: _controller,
    );
  }

  SizedBox _sizedBoxMap() {
    return SizedBox(
      height: mapHeight,
      child: _googleMap(),
    );
  }

  GoogleMap _googleMap() {
    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: _kIstanbul,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: markers,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
    );
  }

  void updateMarkers(OptimizedRoute? value) async {
    Set<Marker> newMarkers = {};

    if (value != null) {
      for (int i = 0; i < value.optimizedWaypoints.length - 1; i++) {
        var element = value.optimizedWaypoints[i];
        final MarkerId markerId = MarkerId("marker${element.hashCode}");

        Uint8List customMarker = await getBytesFromAsset(i);

        final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(
            element.lat,
            element.lng,
          ),
          icon: BitmapDescriptor.fromBytes(customMarker),
        );

        newMarkers.add(marker);
      }

      setState(() {
        markers = newMarkers;
      });
    }
  }

  Future<Uint8List> getBytesFromAsset(int i) async {
    String path =
        i == 0 ? "assets/images/flag.png" : "assets/images/number-$i.png";

    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 100);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
