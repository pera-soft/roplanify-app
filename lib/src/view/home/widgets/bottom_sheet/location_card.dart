import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/core/components/sizedbox/sizedbox.dart';
import 'package:pera/src/view/home/model/place.dart';

class LocationCard extends StatelessWidget with BaseSingleton {
  final ValueNotifier<Place> data;

  const LocationCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: _boxDecoration(),
        child: Column(
          children: [
            _cardTopRow(),
            _selectedLocListtile(),
            _customContainer(),
            _sizeHeight10(),
            _cardBottomRow(),
            _sizeHeight20(),
          ],
        ));
  }

  CustomSizedBox _sizeHeight20() => CustomSizedBox(height: 20);

  Row _cardBottomRow() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Icon(
            FontAwesomeIcons.truck,
            color: colors.blue,
            size: 20,
          ),
        ),
        CustomSizedBox(width: 25),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colors.grey4, width: 1)),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: constants.aracta_yer_elirleyin,
                  hintStyle: TextStyle(color: colors.grey)),
            ),
          ),
        ),
      ],
    );
  }

  CustomSizedBox _sizeHeight10() => CustomSizedBox(height: 10);

  Container _customContainer() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: colors.grey4),
              top: BorderSide(width: 1, color: colors.grey4))),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        decoration: InputDecoration(
            hintText: constants.not_ekle,
            border: InputBorder.none,
            hintStyle: TextStyle(color: colors.grey)),
      ),
    );
  }

  ListTile _selectedLocListtile() {
    return ListTile(
      title: Text(
        data.value.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      subtitle: Text(
        constants.Sumer_Zeytinburnu,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colors.white,
        boxShadow: [BoxShadow(color: colors.grey, blurRadius: 10)]);
  }

  Row _cardTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: colors.green1, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          margin: const EdgeInsets.only(right: 20, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.solidCircleCheck,
                color: colors.green8,
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                constants.Eklendi,
                style: TextStyle(color: colors.green8),
              )
            ],
          ),
        )
      ],
    );
  }
}
