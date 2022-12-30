import 'package:pera/src/view/home/model/location.dart';

class OptimizedRoute {
  final List<Location> optimizedWaypoints;

  OptimizedRoute(this.optimizedWaypoints);

  OptimizedRoute.fromMap(Map<String, dynamic> map)
      : optimizedWaypoints = ((map['optimizedWaypoints'] as List)
            .map((e) => Location.fromMap(e))
            .toList());

  Map<String, dynamic> toMap() {
    return {
      'optimizedWaypoints': optimizedWaypoints.map((e) => e.toMap()).toList(),
    };
  }
}
