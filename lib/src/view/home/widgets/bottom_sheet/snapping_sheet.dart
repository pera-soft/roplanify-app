import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status_enum.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/draggable_section.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/search_bar.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SnappingSheetWidget extends StatefulWidget {
  final ValueChanged<double> mapHeightCallback;

  const SnappingSheetWidget({super.key, required this.mapHeightCallback});

  @override
  State<SnappingSheetWidget> createState() => _SnappingSheetWidgetState();
}

class _SnappingSheetWidgetState extends State<SnappingSheetWidget>
    with BaseSingleton {
  final ScrollController listViewController = ScrollController();
  final snappingSheetController = SnappingSheetController();
  TextEditingController searchController = TextEditingController();
  ValueNotifier<SnappingSheetStatus> status =
      ValueNotifier(SnappingSheetStatus.LOCATIONS);

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
        //mapHeightCallback(data.pixels);
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
          color: colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(blurRadius: 25, color: colors.black.withOpacity(0.2)),
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
                color: colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SearchBar(
                draggableController: snappingSheetController,
                setText: setSearchText,
                controller: searchController,
                status: status),
            Container(
              color: colors.green2,
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
          color: colors.white,
          child: DraggableSection(
              controller: listViewController,
              searchText: searchText,
              status: status),
        ),
      ),
    );
  }
}
