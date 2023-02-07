import 'dart:async';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/text/text_with_googlefonts_widget.dart';
import 'package:pera/src/core/extensions/ui_extensions.dart';
import 'package:pera/src/core/route/app_router.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/viewmodel/set_map_height.dart';
import 'package:pera/src/view/home/service/location_service.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/snapping_sheet.dart';
import 'package:pera/src/view/home/widgets/top_section.dart';
import 'dart:ui' as ui;
import 'package:pera/src/view/login/model/user.dart';
import 'package:pera/src/view/login/service/auth_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final ValueNotifier<AppUser?> user;

  const Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with BaseSingleton {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final Completer<GoogleMapController> _controller = Completer();
  final AuthService authService = AuthService();
  ValueNotifier<List<Place>?> routes = ValueNotifier(null);
  Set<Marker> markers = {};
  ValueNotifier<Set<Polyline>> polylines = ValueNotifier({});
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
                mapHeightCallback: context.read<SetMapHeight>().setDeviceHeight,
                routes: routes,
                polylines: polylines),
          ],
        ),
      ),
    );
  }

  Drawer _drawer() {
    AppUser user = widget.user.value!;

    return Drawer(
      child: Container(
        padding: context.paddingHorizontal2x,
        decoration: BoxDecoration(
            color: colors.white, boxShadow: [BoxShadow(color: colors.black45)]),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  icons.logOut,
                  color: colors.black,
                ),
                onPressed: () async {
                  authService.signOut();
                  context.router.replace(LoginRoute(appUser: widget.user));
                },
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 75,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [colors.blue, Colors.blueAccent])),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: (user.picsUrl.isEmpty)
                          ? const AssetImage("assets/images/placeholder.png")
                          : NetworkImage(user.picsUrl) as ImageProvider,
                    ),
                  ),
                  SizedBox(
                      width: 100,
                      child: TextStyleGenerator(
                        text: user.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        color: colors.black,
                        fontSize: 20.0,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
      polylines: polylines.value,
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

  void updateMarkers(List<Place>? value) async {
    Set<Marker> newMarkers = {};

    if (value != null) {
      for (int i = 0; i < value.length - 1; i++) {
        var element = value[i];
        final MarkerId markerId = MarkerId("marker${element.hashCode}");

        Uint8List customMarker = await getBytesFromAsset(i);

        final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(
            element.latLng.lat,
            element.latLng.lng,
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
