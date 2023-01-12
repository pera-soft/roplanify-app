import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/text/text_with_googlefonts_widget.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/widgets/bottom_sheet/location_card.dart';

class LocationCardSheet extends StatefulWidget {
  final ScrollController controller;
  final ValueNotifier<SnappingSheetStatus> status;
  final ValueNotifier<Place?> selectedData;
  final ValueNotifier<List<Place>> routeLocations;

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
    widget.routeLocations.value.add(widget.selectedData.value!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        children: [_locationCard(), _customContainerButton()],
      ),
    );
  }

  Container _customContainerButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        onPressed: () {
          updateStatus(SnappingSheetStatus.search);
          widget.routeLocations.value.remove(widget.selectedData.value);
        },
        color: colors.red,
        child:
            TextStyleGenerator(text: constants.duragiSil, color: colors.white),
      ),
    );
  }

  LocationCard _locationCard() => LocationCard(data: widget.selectedData);

  updateStatus(SnappingSheetStatus status) {
    widget.status.value = status;
  }
}
