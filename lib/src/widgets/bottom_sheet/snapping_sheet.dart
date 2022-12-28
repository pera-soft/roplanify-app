import 'package:flutter/material.dart';
import 'package:pera/src/model/enums/snapping_sheet_status.dart';
import 'package:pera/src/widgets/bottom_sheet/draggable_section.dart';
import 'package:pera/src/widgets/bottom_sheet/search_bar.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SnappingSheetWidget extends StatefulWidget {
  final ValueChanged<double> mapHeightCallback;

  const SnappingSheetWidget({super.key, required this.mapHeightCallback});

  @override
  State<SnappingSheetWidget> createState() => _SnappingSheetWidgetState();
}

class _SnappingSheetWidgetState extends State<SnappingSheetWidget> {
  final ScrollController listViewController = ScrollController();
  final snappingSheetController = SnappingSheetController();
  TextEditingController searchController = TextEditingController();
  ValueNotifier<SnappingSheetStatus> status =
      ValueNotifier(SnappingSheetStatus.locations);
  ValueNotifier<String> searchText = ValueNotifier("");

  setSearchText() {
    setState(() {
      if(searchController.text.isNotEmpty) {
        searchText.value = searchController.text;
      }
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
      snappingPositions: const [
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
      ],
      grabbing: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SearchBar(
                draggableController: snappingSheetController,
                setText: setSearchText,
                controller: searchController,
                status: status),
            Container(
              color: Colors.grey.shade200,
              height: 2,
              margin: const EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
            )
          ],
        ),
      ),
      grabbingHeight: 90,
      sheetAbove: null,
      sheetBelow: SnappingSheetContent(
        draggable: true,
        childScrollController: listViewController,
        child: Container(
          color: Colors.white,
          child: DraggableSection(
              controller: listViewController,
              searchText: searchText,
              status: status),
        ),
      ),
    );
  }
}
