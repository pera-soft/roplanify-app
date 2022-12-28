import 'package:pera/src/view/home/model/location.dart';

class Place {
  final String id;
  final String name;
  //final String formattedAddress;
  final Location latLng;

  Place(this.id, this.name, this.latLng/*, this.formattedAddress*/);

  Place.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        /*formattedAddress = map['formattedAddress'],*/
        latLng = Location.fromMap(map['latLng']);
}