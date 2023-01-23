import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pera/src/view/home/model/location.dart';

const apiKey = "API_KEY";

class GoogleMapsServices {
  Future<String> getRouteCoordinates(Location l1, Location l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.lat},${l1.lng}&destination=${l2.lat},${l2.lng}&key=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);

    return values["routes"][0]["overview_polyline"]["points"];
  }
}
