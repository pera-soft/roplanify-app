import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/draggable_section.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/search_bar.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SnappingSheetWidget extends StatefulWidget {
  final ValueChanged<double> mapHeightCallback;
  final ValueNotifier<List<Place>?> routes;
  final ValueNotifier<Set<Polyline>?> polylines;

  const SnappingSheetWidget(
      {super.key,
      required this.mapHeightCallback,
      required this.routes,
      required this.polylines});

  @override
  State<SnappingSheetWidget> createState() => _SnappingSheetWidgetState();
}

class _SnappingSheetWidgetState extends State<SnappingSheetWidget>
    with BaseSingleton {
  final ScrollController listViewController = ScrollController();
  final snappingSheetController = SnappingSheetController();
  TextEditingController searchController = TextEditingController();
  ValueNotifier<SnappingSheetStatus> status =
      ValueNotifier(SnappingSheetStatus.locations);
  ValueNotifier<String> searchText = ValueNotifier("");

  setSearchText() {
    setState(() {
      searchText.value = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
      controller: snappingSheetController,
      onSheetMoved: (data) {
        widget.mapHeightCallback(data.pixels);
      },
      lockOverflowDrag: true,
      snappingPositions: _snappingPosition,
      grabbing: _grabbingContainer(),
      grabbingHeight: 90,
      sheetAbove: null,
      sheetBelow: _snappingSheetContent(),
    );
  }

  SnappingSheetContent _snappingSheetContent() {
    return SnappingSheetContent(
      draggable: true,
      childScrollController: listViewController,
      child: _containerDraggableSection(),
    );
  }

  Container _grabbingContainer() {
    return Container(
      decoration: _boxDecorationGrabbing(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_customContainer(), _searchBar(), _containerLine()],
      ),
    );
  }

  Container _containerDraggableSection() {
    return Container(
      color: colors.white,
      child: DraggableSection(
          controller: listViewController,
          searchText: searchText,
          status: status,
          routes: widget.routes,
          polylines: widget.polylines),
    );
  }

  Container _customContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 50,
      height: 5,
      decoration: BoxDecoration(
        color: colors.blue,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Container _containerLine() {
    return Container(
      color: colors.grey2,
      height: 2,
      margin: const EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
    );
  }

  SearchBar _searchBar() {
    return SearchBar(
        draggableController: snappingSheetController,
        setText: setSearchText,
        controller: searchController,
        status: status);
  }

  BoxDecoration _boxDecorationGrabbing() {
    return BoxDecoration(
      color: colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      boxShadow: [
        BoxShadow(blurRadius: 25, color: colors.black.withOpacity(0.2)),
      ],
    );
  }

  List<SnappingPosition> get _snappingPosition {
    return const [
      SnappingPosition.factor(
        positionFactor: 0.0,
        snappingDuration: Duration(seconds: 1),
        grabbingContentOffset: GrabbingContentOffset.top,
      ),
      SnappingPosition.factor(
        snappingDuration: Duration(seconds: 1),
        grabbingContentOffset: GrabbingContentOffset.middle,
        positionFactor: 0.5,
      ),
      SnappingPosition.factor(
        snappingDuration: Duration(seconds: 1),
        positionFactor: 1,
        grabbingContentOffset: GrabbingContentOffset.bottom,
      ),
    ];
  }
}
