import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/view/home/model/optimized_route.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/model/routes.dart';
import 'package:pera/src/view/home/service/api_service.dart';

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
                : _customListViewBuilder()),
        _customContainerButton()
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
        onPressed: () async{
          OptimizedRoute or = await apiService.optimizeRoute(widget.routeLocations.value);
          widget.optimizedRoutes.value = or;
        },
        color: colors.blue,
        child: Text(
          constants.rotayiOptimizeEt,
          style: TextStyle(color: colors.white),
        ),
      ),
    );
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
      )),
    );
  }
}
