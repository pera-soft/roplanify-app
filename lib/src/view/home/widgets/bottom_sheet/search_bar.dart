import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/sizedbox/custom_sized_box.dart';
import 'package:pera/src/core/constants/enums/snapping_sheet_status.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
  SpeechToText speechToText = SpeechToText();
  bool _isListening = false;
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
          decoration: _boxDecoration(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _customSearchBarIcon(),
                    _searchbar(screenHeight),
                    _opacity(),
                    clearButtonVisibility
                        ? Opacity(
                            opacity: 0.6,
                            child: IconButton(
                              onPressed: _onPressedIconButton,
                              icon: _searchBarVisibilityClearIcon(),
                            ),
                          )
                        : CustomSizedBox()
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onPressedIconButton() {
    FocusManager.instance.primaryFocus?.unfocus();
    widget.controller.clear();
    if (mounted) {
      setState(() {
        clearButtonVisibility = false;
        widget.status.value = SnappingSheetStatus.locations;
      });
    }
  }

  Opacity _opacity() {
    return Opacity(
      opacity: 0.6,
      child: SizedBox(
        height: 40,
        child: AvatarGlow(
          endRadius: 20,
          animate: _isListening,
          startDelay: const Duration(milliseconds: 1000),
          duration: const Duration(milliseconds: 5000),
          repeat: true,
          repeatPauseDuration: const Duration(milliseconds: 100),
          showTwoGlows: true,
          child: GestureDetector(
            onTap: () async {
              if (!_isListening) {
                var available = await speechToText.initialize(
                  onStatus: (val) => print('onStatus: $val'),
                  onError: (val) => print('onError: $val'),
                );
                if (available) {
                  setState(() {
                    _isListening = true;
                    speechToText.listen(
                      onResult: (val) => setState(() {
                        widget.controller.text = val.recognizedWords;
                        _isListening = false;
                        clearButtonVisibility = true;

                        if (widget.controller.text.isNotEmpty) {
                          if (mounted) {
                            setState(() {
                              widget.status.value = SnappingSheetStatus.search;
                              widget.setText();
                            });
                          }
                        }
                      }),
                    );
                  });
                }
              } else {
                setState(() {
                  _isListening = false;
                });
                speechToText.stop();
              }
            },
            child: CircleAvatar(
              radius: 20,
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                color: _isListening ? colors.red : colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _searchbar(double screenHeight) {
    return Expanded(
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
                    grabbingContentOffset: GrabbingContentOffset.middle,
                  ),
                );
              } else if (widget.draggableController.currentPosition <
                  screenHeight * 0.5) {
                widget.draggableController.snapToPosition(
                  const SnappingPosition.factor(
                    positionFactor: 1,
                    snappingDuration: Duration(seconds: 1),
                    grabbingContentOffset: GrabbingContentOffset.bottom,
                  ),
                );
              }
            },
            onSubmitted: (String val) {
              if (val.isNotEmpty) {
                if (mounted) {
                  setState(() {
                    widget.status.value = SnappingSheetStatus.search;
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
            style: TextStyle(color: colors.white, fontSize: 16),
            cursorColor: colors.white,
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: constants.durakEkle,
              hintStyle: TextStyle(
                color: colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Icon _searchBarVisibilityClearIcon() {
    return Icon(
      icons.xmark,
      color: colors.white,
      size: 20,
    );
  }

  Icon _customSearchBarIcon() =>
      Icon(icons.search, color: colors.white, size: 20);

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
    );
  }
}
