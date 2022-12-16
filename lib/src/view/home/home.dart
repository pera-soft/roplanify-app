import 'package:flutter/material.dart';
import 'package:pera/src/widgets/draggable_section.dart';
import 'package:pera/src/widgets/top_section.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  double top = 0.0;
  double initialTop = 0.0;

  @override
  Widget build(BuildContext context) {
    final baseTop = MediaQuery.of(context).size.height * 0.6;
    const searchBarHeight = 54.0;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      body: Stack(
        children: [
          Container(),
          TopSection(
            drawerKey: _scaffoldKey,
          ),
          GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              final double scrollPos = details.globalPosition.dy;
              if (scrollPos < baseTop && scrollPos > searchBarHeight) {
                setState(() {
                  top = scrollPos;
                });
              }
            },
            child: DraggableSection(
              top: top == 0.0 ? baseTop : top,
              searchBarHeight: searchBarHeight,
            ),
          ),
        ],
      ),
    );
  }
}
