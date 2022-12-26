import 'package:flutter/material.dart';
import 'package:pera/src/model/enums/SnappingSheetStatus.dart';
import 'package:pera/src/widgets/bottom_sheet/location_card.dart';

class LocationCardSheet extends StatefulWidget {
  final ScrollController controller;
  final ValueNotifier<SnappingSheetStatus> status;
  final ValueNotifier<Map<String, dynamic>> selectedData;
  final ValueNotifier<List<Map<String, dynamic>>> routeLocations;

  const LocationCardSheet({Key? key, required this.controller, required this.status, required this.selectedData, required this.routeLocations}) : super(key: key);

  @override
  State<LocationCardSheet> createState() => _LocationCardSheetState();
}

class _LocationCardSheetState extends State<LocationCardSheet> {
  @override
  void initState() {
    super.initState();
    widget.routeLocations.value.add(widget.selectedData.value);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        children: [
          LocationCard(data: widget.selectedData),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 5),
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              onPressed: () {
                updateStatus(SnappingSheetStatus.SEARCH);
                widget.routeLocations.value.remove(widget.selectedData.value);
              },
              color: Colors.red,
              child: const Text(
                "Durağı Sil",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  updateStatus(SnappingSheetStatus s) {
    widget.status.value = s;
  }
}