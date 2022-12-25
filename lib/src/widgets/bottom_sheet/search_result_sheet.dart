import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pera/src/model/enums/SnappingSheetStatus.dart';
import 'package:pera/src/services/TestService.dart';

class SearchResultSheet extends StatelessWidget {
  final ScrollController controller;
  final ValueNotifier<String> searchText;
  final ValueNotifier<SnappingSheetStatus> status;
  final ValueNotifier<Map<String, dynamic>> selectedData;

  SearchResultSheet({Key? key, required this.controller, required this.searchText, required this.status, required this.selectedData}) : super(key: key);

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
                        leading: const Icon(Icons.add_location_outlined,
                            size: 30),
                        title: Text(data['title']),
                        subtitle: const Text(
                          "Sümer, Zeytinburnu",
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing:
                        const Icon(FontAwesomeIcons.angleRight),
                        onTap: () {
                          updateStatus(SnappingSheetStatus.CARD);
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

  updateSelected(Map<String, dynamic> d) {
    selectedData.value = d;
  }
}
