import 'package:flutter/material.dart';
import 'package:pera/src/widgets/search_bar.dart';

class DraggableSection extends StatelessWidget {
  final double top;
  final double searchBarHeight;

  const DraggableSection(
      {super.key, required this.top, required this.searchBarHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1.1,
      margin: EdgeInsets.only(top: top),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 30,
            color: Colors.grey.shade300,
          )
        ],
      ),
      child: Stack(
        children: <Widget>[
          ListView(children: <Widget>[Container()]),
          SearchBar(baseTop: top == 0.0 ? 0.0 : top, height: searchBarHeight),
        ],
      ),
    );
  }
}
