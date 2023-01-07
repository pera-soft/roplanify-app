import 'package:pera/src/view/home/model/location.dart';

class Routes {
  final String travelMode;
  final Location origin;
  final List<Location> waypoints;
  final Location destination;

  Routes(this.travelMode, this.origin, this.waypoints, this.destination);

  Routes.fromMap(Map<String, dynamic> map)
      : travelMode = map['travelMode'],
        origin = Location.fromMap(map['origin']),
        waypoints = ((map['waypoints'] as List)
            .map((e) => Location.fromMap(e))
            .toList()),
        destination = Location.fromMap(map['destination']);

  Map<String, dynamic> toMap() {
    return {
      'travelMode': travelMode,
      'origin': origin.toMap(),
      'waypoints': waypoints.map((e) => e.toMap()).toList(),
      'destination': destination.toMap()
    };
  }
}
