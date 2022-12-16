import 'package:flutter/material.dart';

import 'fancybar.dart';

class TopSection extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  const TopSection({super.key,required this.drawerKey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  drawerKey.currentState!.openDrawer();
                },
                child: const FancyBar(
                  height: 46,
                  margin: EdgeInsets.only(left: 20, top: 40),
                  child: Icon(Icons.menu, color: Colors.black, size: 20),
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              FancyBar(
                height: 46,
                margin: const EdgeInsets.only(right: 20, top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        print("mesaj");
                      },
                      child: Transform.rotate(
                          angle: 3.14 / 4,
                          child: const Icon(Icons.navigation,
                              color: Colors.black, size: 20)),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}