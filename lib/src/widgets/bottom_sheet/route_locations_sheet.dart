import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pera/src/model/place.dart';

class RouteLocationsSheet extends StatefulWidget {
  final ScrollController scrollController;
  final ValueNotifier<List<Place>> routeLocations;

  const RouteLocationsSheet(
      {Key? key, required this.scrollController, required this.routeLocations})
      : super(key: key);

  @override
  State<RouteLocationsSheet> createState() => _RouteLocationsSheetState();
}

class _RouteLocationsSheetState extends State<RouteLocationsSheet> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: widget.scrollController,
          child: widget.routeLocations.value.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(50),
                  child: const Center(
                      child: Text(
                    "Durak eklemek için üst kısımdaki arama çubuğunu kullanın",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  )),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.routeLocations.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          Place data =
                              widget.routeLocations.value[index];

                          return ListTile(
                            leading: const Icon(Icons.circle,
                                size: 15, color: Colors.blue),
                            title: Text(data.name),
                            subtitle: const Text(
                              "Sümer, Zeytinburnu",
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: const Icon(FontAwesomeIcons.angleRight),
                            onTap: () {},
                          );
                        },
                      ),
                      const SizedBox(height: 50)
                    ],
                  ),
                ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            onPressed: () {},
            color: Colors.blue,
            child: const Text(
              "Rotayı Optimize Et",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
