import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pera/src/model/optimized_route.dart';
import 'package:pera/src/model/place.dart';
import 'package:pera/src/model/route.dart';

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

  Future<OptimizedRoute> optimizeRoute(Route route) async {
    var data = await http.post(
        Uri.parse('https://roplanify.ey.r.appspot.com/api/route/optimize'),
        body: jsonEncode(route.toMap()));

    OptimizedRoute r =
        OptimizedRoute.fromMap(jsonDecode(utf8.decode(data.bodyBytes)));

    return r;
  }
}
