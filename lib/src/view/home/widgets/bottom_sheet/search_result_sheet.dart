import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/Listtile/search_result_listtile.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/service/api_service.dart';

class SearchResultSheet extends StatelessWidget with BaseSingleton {
  final ScrollController controller;
  final ValueNotifier<String> searchText;
  final ValueNotifier<SnappingSheetStatus> status;
  final ValueNotifier<Place> selectedData;

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

                      return _searchResultlisttile(data);
                    } else {
                      return _centerCircularProgess();
                    }
                  },
                ),
              );
            })
      ],
    );
  }

  Center _centerCircularProgess() {
    return const Center(child: CircularProgressIndicator());
  }

  SearchResultListTile _searchResultlisttile(Place data) {
    return SearchResultListTile(
      leading: Icon(icons.add_location_outlined, size: 30),
      title: Text(data.name),
      subtitle: Text(
        constants.Sumer_Zeytinburnu,
        style: TextStyle(color: colors.grey),
      ),
      trailing: Icon(icons.angleRight),
      ontop: () {
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
