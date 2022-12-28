import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pera/src/view/home/model/place.dart';

class LocationCard extends StatelessWidget {
  final ValueNotifier<Place> data;

  const LocationCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                  margin: const EdgeInsets.only(right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.solidCircleCheck,
                        color: Colors.green.shade800,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Eklendi",
                        style: TextStyle(color: Colors.green.shade800),
                      )
                    ],
                  ),
                )
              ],
            ),
            ListTile(
              title: Text(
                data.value.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              subtitle: const Text(
                "Sümer, Zeytinburnu",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey.shade400),
                      top: BorderSide(width: 1, color: Colors.grey.shade400))),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const TextField(
                decoration: InputDecoration(
                    hintText: "Not Ekle",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Icon(
                    FontAwesomeIcons.truck,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 1)),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Araçta Yer Belirleyin",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
