import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/view/home/model/place.dart';

class RouteLocationsSheet extends StatefulWidget {
  final ScrollController scrollController;
  final ValueNotifier<List<Place>> routeLocations;

  const RouteLocationsSheet(
      {Key? key, required this.scrollController, required this.routeLocations})
      : super(key: key);

  @override
  State<RouteLocationsSheet> createState() => _RouteLocationsSheetState();
}

class _RouteLocationsSheetState extends State<RouteLocationsSheet>
    with BaseSingleton {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: widget.scrollController,
        child: widget.routeLocations.value.isEmpty
            ? _customContainer()
            : _rootLocationColumn());
  }

  Column _rootLocationColumn() {
    return Column(
      children: [_customListViewBuilder(), _customContainerButton()],
    );
  }

  Container _customContainerButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        onPressed: () {},
        color: colors.blue,
        child: Text(
          constants.Rotayi_Optimize_Et,
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
            title: Text(data.name),
            subtitle: Text(
              constants.Sumer_Zeytinburnu,
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
        constants.Durak_eklemek_icin,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: colors.grey),
        textAlign: TextAlign.center,
      )),
    );
  }
}
