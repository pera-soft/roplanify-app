import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/service/api_service.dart';

class SearchResultSheet extends StatelessWidget {
  final ScrollController controller;
  final ValueNotifier<String> searchText;
  final ValueNotifier<SnappingSheetStatus> status;
  final ValueNotifier<Place> selectedData;

  SearchResultSheet({Key? key, required this.controller, required this.searchText, required this.status, required this.selectedData}) : super(key: key);

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

                      return ListTile(
                        leading: const Icon(Icons.add_location_outlined,
                            size: 30),
                        title: Text(data.name),
                        subtitle: const Text(
                          "Sümer, Zeytinburnu",
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing:
                        const Icon(FontAwesomeIcons.angleRight),
                        onTap: () {
                          updateStatus(SnappingSheetStatus.card);
                          updateSelected(data);
                        },
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                  },
                ),
              );
            })
      ],
    );
  }

  updateStatus(SnappingSheetStatus s) {
    status.value = s;
  }

  updateSelected(Place place) {
    selectedData.value = place;
  }
}
