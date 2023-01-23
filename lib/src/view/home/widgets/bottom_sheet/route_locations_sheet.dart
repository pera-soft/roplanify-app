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
                /*: widget.optimizedRoutes.value != null
                    ? _customRouteListView()*/
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
          apiService.optimizeRoute(widget.routeLocations.value).then((value) {
            widget.routeLocations.value = value;
          });

          sendRequest();
        },
        color: colors.blue,
        child: TextStyleGenerator(
            text: constants.rotayiOptimizeEt, color: colors.white),
      ),
    );
  }

  /*ListView _customRouteListView() {
    List<Place> or = [];
    for (var routeItem in widget.optimizedRoutes.value!.optimizedWaypoints) {
      Iterable places = widget.routeLocations.value.where((locationItem) {
        return locationItem.latLng.lng == routeItem.lng &&
            locationItem.latLng.lat == routeItem.lat;
      });
      if (places.isNotEmpty) {
        or.add(places.first);
      }
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: or.length,
        itemBuilder: (BuildContext context, int index) {
          Place data = or[index];

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
            onTap: () {},
          );
        });
  }*/

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
            onTap: () {},
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

  void sendRequest() async {
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
    for (var element in encondedPolies) {
      widget.polylines.value!.add(Polyline(
          polylineId: PolylineId("${element.hashCode}"),
          width: 4,
          points: _convertToLatLng(_decodePoly(element)),
          color: colors.blueAccent));
    }

    Navigator.pop(context);
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
