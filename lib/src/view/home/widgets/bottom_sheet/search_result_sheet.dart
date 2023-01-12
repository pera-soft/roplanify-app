import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/Listtile/search_result_listtile.dart';
import 'package:pera/src/core/components/circularProgressIndicator/circular_progress_indicator.dart';
import 'package:pera/src/core/components/text/text_with_googlefonts_widget.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/service/api_service.dart';

class SearchResultSheet extends StatelessWidget with BaseSingleton {
  final ScrollController controller;
  final ValueNotifier<String> searchText;
  final ValueNotifier<SnappingSheetStatus> status;
  final ValueNotifier<Place?> selectedData;

  SearchResultSheet(
      {Key? key,
      required this.controller,
      required this.searchText,
      required this.status,
      required this.selectedData})
      : super(key: key);

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: apiService.searchPlace(searchText.value),
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: snapshot.hasData ? snapshot.data?.length : 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.hasData) {
                      Place data = snapshot.data?[index];

                      return _searchResultListTile(data);
                    } else {
                      return _centerCircularProgress();
                    }
                  },
                ),
              );
            })
      ],
    );
  }

  Center _centerCircularProgress() {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(10.0),
      child: CircularProgress(),
    ));
  }

  SearchResultListTile _searchResultListTile(Place data) {
    return SearchResultListTile(
      leading: const Icon(Icons.add_location_outlined, size: 30),
      title: TextStyleGenerator(
        text: data.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: TextStyleGenerator(
          text: data.formattedAddress,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          color: colors.grey),
      trailing: Icon(icons.angleRight),
      onTap: () {
        updateStatus(SnappingSheetStatus.card);
        updateSelected(data);
      },
    );
  }

  updateStatus(SnappingSheetStatus s) {
    status.value = s;
  }

  updateSelected(Place place) {
    selectedData.value = place;
  }
}
