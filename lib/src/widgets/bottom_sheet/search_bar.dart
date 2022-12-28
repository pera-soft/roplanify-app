import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pera/src/model/enums/snapping_sheet_status.dart';
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

class _SearchBarState extends State<SearchBar> {
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
                  children: <Widget>[
                    const Icon(Icons.search, color: Colors.white, size: 20),
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
                              if(val.isNotEmpty){
                                if (mounted) {
                                  setState(() {
                                    widget.status.value =
                                        SnappingSheetStatus.search;
                                    widget.setText();
                                  });
                                }
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
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            cursorColor: Colors.white,
                            decoration: const InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: 'Durak Ekle',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Opacity(
                        opacity: 0.6,
                        child: Icon(Icons.mic, color: Colors.white, size: 20)),
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
                                          SnappingSheetStatus.locations;
                                    });
                                  }
                                },
                                icon: const Icon(FontAwesomeIcons.xmark,
                                    color: Colors.white, size: 20)))
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
