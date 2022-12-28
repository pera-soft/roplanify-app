import 'package:flutter/material.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status.dart';
import 'package:pera/src/view/home/model/location.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/location_card_sheet.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/route_locations_sheet.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/search_result_sheet.dart';

class DraggableSection extends StatefulWidget {
  final ValueNotifier<SnappingSheetStatus> status;
  final ScrollController controller;
  final ValueNotifier<String> searchText;

  const DraggableSection(
      {super.key,
      required this.controller,
      required this.searchText,
      required this.status});

  @override
  State<DraggableSection> createState() => _DraggableSectionState();
}

class _DraggableSectionState extends State<DraggableSection> {
  ValueNotifier<Place> selectedData =
      ValueNotifier(Place("", "", Location(0, 0)));
  ValueNotifier<List<Place>> routeLocations = ValueNotifier([]);
  late SnappingSheetStatus status;

  @override
  void initState() {
    super.initState();
    status = widget.status.value;
    widget.status.addListener(() {
      setState(() {
        status = widget.status.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: status == SnappingSheetStatus.search
          ? SearchResultSheet(
              controller: widget.controller,
              status: widget.status,
              searchText: widget.searchText,
              selectedData: selectedData)
          : status == SnappingSheetStatus.locations
              ? RouteLocationsSheet(
                  scrollController: widget.controller,
                  routeLocations: routeLocations)
              : LocationCardSheet(
                  controller: widget.controller,
                  status: widget.status,
                  routeLocations: routeLocations,
                  selectedData: selectedData),
    );
  }
}
