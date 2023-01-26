import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/text/text_with_googlefonts_widget.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/service/api_service.dart';
import 'package:pera/src/view/home/service/route_service.dart';
import 'package:pera/src/view/home/widgets/loading/loading.dart';

class RouteLocationsSheet extends StatefulWidget {
  final ScrollController scrollController;
  final ValueNotifier<List<Place>> routeLocations;
  final ValueNotifier<List<Place>?> optimizedRoutes;
  final ValueNotifier<Set<Polyline>?> polylines;

  const RouteLocationsSheet(
      {Key? key,
      required this.scrollController,
      required this.routeLocations,
      required this.optimizedRoutes,
      required this.polylines})
      : super(key: key);

  @override
  State<RouteLocationsSheet> createState() => _RouteLocationsSheetState();
}

class _RouteLocationsSheetState extends State<RouteLocationsSheet>
    with BaseSingleton {
  ApiService apiService = ApiService();
  final GoogleMapsServices _googleMapsServices = GoogleMapsServices();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
            controller: widget.scrollController,
            child: widget.routeLocations.value.isEmpty
                ? _customContainer()
                : widget.optimizedRoutes.value != null
                    ? _customRouteListView()
                    : _customListViewBuilder()),
        widget.routeLocations.value.isEmpty
            ? Container()
            : _customContainerButton()
      ],
    );
  }

  Container _customContainerButton() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        onPressed: () async {
          await showLoadingDialog();
          List<Place> optimize =
              await apiService.optimizeRoute(widget.routeLocations.value);
          widget.optimizedRoutes.value = optimize;
          await sendRequest();
        },
        color: colors.blue,
        child: TextStyleGenerator(
            text: constants.rotayiOptimizeEt, color: colors.white),
      ),
    );
  }

  ListView _customRouteListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.optimizedRoutes.value!.length,
        itemBuilder: (BuildContext context, int index) {
          Place data = widget.optimizedRoutes.value![index];

          return ListTile(
            leading: Text("${index + 1}"),
            title: Text(
              data.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              data.formattedAddress,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colors.grey),
            ),
            onTap: () {
              openMapsForAndroid(data.latLng.lat, data.latLng.lng);
            },
          );
        });
  }

  ListView _customListViewBuilder() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.routeLocations.value.length,
        itemBuilder: (BuildContext context, int index) {
          Place data = widget.routeLocations.value[index];

          return ListTile(
            leading: Icon(
              Icons.circle,
              size: 15,
              color: colors.blue,
            ),
            title: Text(
              data.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              data.formattedAddress,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colors.grey),
            ),
            trailing: Icon(icons.angleRight),
            onTap: () {
              openMapsForAndroid(data.latLng.lat, data.latLng.lng);
            },
          );
        });
  }

  Container _customContainer() {
    return Container(
      padding: const EdgeInsets.all(50),
      child: Center(
        child: Text(
          constants.durakEklemekIcin,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  showLoadingDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoadingPopup();
        });
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  Future sendRequest() async {
    widget.polylines.value = {};
    List<String> routes = [];

    for (int i = 0; i < widget.optimizedRoutes.value!.length - 1; i++) {
      Place destination = widget.optimizedRoutes.value![i + 1];
      Place start = widget.optimizedRoutes.value![i];
      String route = await _googleMapsServices.getRouteCoordinates(
          start.latLng, destination.latLng);
      routes.add(route);
    }
    createRoute(routes);
  }

  void createRoute(List<String> encondedPolies) {
    List<Color> colorList = [
      colors.blue,
      colors.red,
      colors.green,
      colors.purple
    ];

    for (int i = 0; i < encondedPolies.length; i++) {
      widget.polylines.value!.add(Polyline(
          polylineId: PolylineId("${encondedPolies[i].hashCode}"),
          width: 4,
          points: _convertToLatLng(_decodePoly(encondedPolies[i])),
          color: colorList[i % 4]));
    }

    Navigator.pop(context);
  }

  void openMapsForIos(double destinationLat, double destinationLng) async {}

  void openMapsForAndroid(double destinationLat, double destinationLng) async {
    // final availableMaps = await MapLauncher.installedMaps;
    //
    // await availableMaps.first
    //     .showDirections(destination: Coords(destinationLat, destinationLng));

    // String googleUrl =
    //     'https://www.google.com/maps/search/?api=1&query=$destinationLat,$destinationLng';
    // if (await canLaunchUrl(Uri.parse(googleUrl))) {
    //   await launchUrl(Uri.parse(googleUrl));
    // } else {
    //   throw 'Could not open the map.';
    // }

    final intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull(
            "google.navigation:q=$destinationLat,$destinationLng&avoid=tf"),
        package: 'com.google.android.apps.maps');
    intent.launch();
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) {
      lList[i] += lList[i - 2];
    }

    print(lList.toString());

    return lList;
  }
}
