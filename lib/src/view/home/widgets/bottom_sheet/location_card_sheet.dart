import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status_enum.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/location_card.dart';

class LocationCardSheet extends StatefulWidget {
  final ScrollController controller;
  final ValueNotifier<SnappingSheetStatus> status;
  final ValueNotifier<Map<String, dynamic>> selectedData;
  final ValueNotifier<List<Map<String, dynamic>>> routeLocations;

  const LocationCardSheet(
      {Key? key,
      required this.controller,
      required this.status,
      required this.selectedData,
      required this.routeLocations})
      : super(key: key);

  @override
  State<LocationCardSheet> createState() => _LocationCardSheetState();
}

class _LocationCardSheetState extends State<LocationCardSheet>
    with BaseSingleton {
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
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              onPressed: () {
                updateStatus(SnappingSheetStatus.SEARCH);
                widget.routeLocations.value.remove(widget.selectedData.value);
              },
              color: colors.red,
              child: Text(
                constants.duragi_sil,
                style: TextStyle(color: colors.white),
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
