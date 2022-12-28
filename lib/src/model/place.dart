import 'package:pera/src/model/location.dart';

class Place {
  final String id;
  final String name;
  final Location latLng;

  Place(this.id, this.name, this.latLng);

  Place.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        latLng = Location.fromMap(map['latLng']);
}
