import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/Icon/search_bar_%C4%B1con.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status_enum.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SearchBar extends StatefulWidget {
  final SnappingSheetController draggableController;
  final TextEditingController controller;
  final Function setText;
  final ValueNotifier<SnappingSheetStatus> status;

  const SearchBar(
      {super.key,
      required this.draggableController,
      required this.setText,
      required this.controller,
      required this.status});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with BaseSingleton {
  bool clearButtonVisibility = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 54,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomSearchBarIcon(
                      icon: icons.search,
                      size: 20,
                      color: colors.white,
                    ),
                    Expanded(
                      child: Opacity(
                        opacity: 0.8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            controller: widget.controller,
                            onTap: () {
                              if (widget.draggableController.currentPosition <
                                  screenHeight * 0.1) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                widget.draggableController.snapToPosition(
                                  const SnappingPosition.factor(
                                    positionFactor: 0.5,
                                    snappingDuration: Duration(seconds: 1),
                                    grabbingContentOffset:
                                        GrabbingContentOffset.middle,
                                  ),
                                );
                              } else if (widget
                                      .draggableController.currentPosition <
                                  screenHeight * 0.5) {
                                widget.draggableController.snapToPosition(
                                  const SnappingPosition.factor(
                                    positionFactor: 1,
                                    snappingDuration: Duration(seconds: 1),
                                    grabbingContentOffset:
                                        GrabbingContentOffset.bottom,
                                  ),
                                );
                              }
                            },
                            onSubmitted: (String val) {
                              if (mounted) {
                                setState(() {
                                  widget.status.value =
                                      SnappingSheetStatus.SEARCH;
                                });
                              }
                            },
                            onChanged: (String val) {
                              if (widget.controller.text.isNotEmpty) {
                                if (mounted) {
                                  setState(() {
                                    clearButtonVisibility = true;
                                  });
                                }
                              } else {
                                if (mounted) {
                                  setState(() {
                                    clearButtonVisibility = false;
                                  });
                                }
                              }
                            },
                            style: TextStyle(color: colors.white, fontSize: 16),
                            cursorColor: colors.white,
                            decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: constants.Durak_Ekle,
                              hintStyle: TextStyle(
                                color: colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                        opacity: 0.6,
                        child: CustomSearchBarIcon(
                            icon: icons.mic, size: 20, color: colors.white)),
                    clearButtonVisibility
                        ? Opacity(
                            opacity: 0.6,
                            child: IconButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  widget.controller.clear();
                                  if (mounted) {
                                    setState(() {
                                      clearButtonVisibility = false;
                                      widget.status.value =
                                          SnappingSheetStatus.LOCATIONS;
                                    });
                                  }
                                },
                                icon: CustomSearchBarIcon(
                                  color: colors.white,
                                  size: 20,
                                  icon: icons.xmark,
                                )))
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
