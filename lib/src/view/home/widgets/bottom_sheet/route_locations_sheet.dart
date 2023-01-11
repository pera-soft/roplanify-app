import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/view/home/model/optimized_route.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/service/api_service.dart';
import 'package:pera/src/view/home/widgets/loading/loading.dart';

class RouteLocationsSheet extends StatefulWidget {
  final ScrollController scrollController;
  final ValueNotifier<List<Place>> routeLocations;
  final ValueNotifier<OptimizedRoute?> optimizedRoutes;

  const RouteLocationsSheet(
      {Key? key,
      required this.scrollController,
      required this.routeLocations,
      required this.optimizedRoutes})
      : super(key: key);

  @override
  State<RouteLocationsSheet> createState() => _RouteLocationsSheetState();
}

class _RouteLocationsSheetState extends State<RouteLocationsSheet>
    with BaseSingleton {
  ApiService apiService = ApiService();

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
            widget.optimizedRoutes.value = value;
            Navigator.pop(context);
          });
        },
        color: colors.blue,
        child: Text(
          constants.rotayiOptimizeEt,
          style: TextStyle(color: colors.white),
        ),
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
}
