import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pera/src/core/base/base_singleton.dart';

class RouteLocationsSheet extends StatefulWidget {
  final ScrollController scrollController;
  final ValueNotifier<List<Map<String, dynamic>>> routeLocations;

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
            ? Container(
                padding: const EdgeInsets.all(50),
                child: Center(
                    child: Text(
                  constants.Durak_eklemek_icin,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: colors.grey),
                  textAlign: TextAlign.center,
                )),
              )
            : Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.routeLocations.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> data =
                            widget.routeLocations.value[index];

                        return ListTile(
                          leading:
                              const Icon(Icons.add_location_outlined, size: 30),
                          title: Text(data['title']),
                          subtitle: Text(
                            constants.Sumer_Zeytinburnu,
                            style: TextStyle(color: colors.grey),
                          ),
                          trailing: Icon(icons.angleRight),
                          onTap: () {},
                        );
                      }),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      onPressed: () {},
                      color: colors.blue,
                      child: Text(
                        constants.Rotayi_Optimize_Et,
                        style: TextStyle(color: colors.white),
                      ),
                    ),
                  )
                ],
              ));
  }
}
