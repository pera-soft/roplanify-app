import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pera/src/view/home/model/optimized_route.dart';
import 'package:pera/src/view/home/model/place.dart';
import 'package:pera/src/view/home/model/route.dart';

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
    Route route = Route("DRIVING", routes[0].latLng, routes.getRange(1, routes.length).map((e) {
      return e.latLng;
    }).toList(), routes[0].latLng);
    print(route.toMap());
    var data = await http.post(
        Uri.parse('https://roplanify.ey.r.appspot.com/api/route/optimize'),
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
        },
        body: jsonEncode(route.toMap()));
    print(jsonDecode(data.body));
    OptimizedRoute r =
        OptimizedRoute.fromMap(jsonDecode(utf8.decode(data.bodyBytes)));

    print(r.optimizedWaypoints);
    return r;
  }
}
