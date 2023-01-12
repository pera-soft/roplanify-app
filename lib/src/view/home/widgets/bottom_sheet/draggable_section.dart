import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status.dart';
import 'package:pera/src/view/home/model/optimized_route.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/location_card_sheet.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/route_locations_sheet.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/search_result_sheet.dart';

class DraggableSection extends StatefulWidget {
  final ValueNotifier<SnappingSheetStatus> status;
  final ScrollController controller;
  final ValueNotifier<String> searchText;
  final ValueNotifier<OptimizedRoute?> routes;

  const DraggableSection(
      {super.key,
      required this.controller,
      required this.searchText,
      required this.status,
      required this.routes});

  @override
  State<DraggableSection> createState() => _DraggableSectionState();
}

class _DraggableSectionState extends State<DraggableSection>
    with BaseSingleton {
  ValueNotifier<Place?> selectedData = ValueNotifier(null);
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
      decoration: _boxDecoration(),
      child: status == SnappingSheetStatus.search
          ? _searchResultSheet()
          : status == SnappingSheetStatus.locations
              ? _routeLocationSheet()
              : _locationCardSheet(),
    );
  }

  LocationCardSheet _locationCardSheet() {
    return LocationCardSheet(
        controller: widget.controller,
        status: widget.status,
        routeLocations: routeLocations,
        selectedData: selectedData);
  }

  RouteLocationsSheet _routeLocationSheet() {
    return RouteLocationsSheet(
        scrollController: widget.controller,
        routeLocations: routeLocations,
        optimizedRoutes: widget.routes);
  }

  SearchResultSheet _searchResultSheet() {
    return SearchResultSheet(
        controller: widget.controller,
        status: widget.status,
        searchText: widget.searchText,
        selectedData: selectedData);
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      boxShadow: [
        BoxShadow(blurRadius: 25, color: colors.black.withOpacity(0.2)),
      ],
    );
  }
}
