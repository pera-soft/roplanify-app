import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:pera/src/view/home/model/location.dart';
import 'package:pera/src/view/home/model/optimized_route.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/model/routes.dart';
import 'package:pera/src/view/home/service/location_service.dart';

class ApiService {
  Future<List> searchPlace(String text) async {
    var data = await http.get(Uri.parse(
        'https://roplanify.ey.r.appspot.com/api/place/search?input=$text'));

    List<Place> list =
        (jsonDecode(utf8.decode(data.bodyBytes)) as List).map((e) {
      return Place.fromMap(e);
    }).toList();

    return list;
  }

  Future<OptimizedRoute> optimizeRoute(List<Place> routes) async {
    LocationService ls = LocationService();
    Position currentLocation = await ls.getCurrentLocation();
    Location currentPosition =
        Location(currentLocation.latitude, currentLocation.longitude);

    Routes route = Routes(
        "DRIVING",
        currentPosition,
        routes.map((e) {
          return e.latLng;
        }).toList(),
        currentPosition);

    var data = await http.post(
        Uri.parse('https://roplanify.ey.r.appspot.com/api/route/optimize'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(route.toMap()));

    OptimizedRoute optimizedRoute =
        OptimizedRoute.fromMap(jsonDecode(utf8.decode(data.bodyBytes)));

    return optimizedRoute;
  }
}
