import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status_enum.dart';
import 'package:pera/src/view/home/service/TestService.dart';

class SearchResultSheet extends StatelessWidget with BaseSingleton {
  final ScrollController controller;
  final ValueNotifier<String> searchText;
  final ValueNotifier<SnappingSheetStatus> status;
  final ValueNotifier<Map<String, dynamic>> selectedData;

  SearchResultSheet(
      {Key? key,
      required this.controller,
      required this.searchText,
      required this.status,
      required this.selectedData})
      : super(key: key);

  TestService testService = TestService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: testService.fetchData(searchText.value),
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: snapshot.hasData ? snapshot.data?.length : 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data = snapshot.data?[index];

                      return ListTile(
                        leading: Icon(icons.add_location_outlined, size: 30),
                        title: Text(data['title']),
                        subtitle: Text(
                          constants.Sumer_Zeytinburnu,
                          style: TextStyle(color: colors.grey),
                        ),
                        trailing: const Icon(FontAwesomeIcons.angleRight),
                        onTap: () {
                          updateStatus(SnappingSheetStatus.CARD);
                          updateSelected(data);
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
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

  updateSelected(Map<String, dynamic> d) {
    selectedData.value = d;
  }
}
