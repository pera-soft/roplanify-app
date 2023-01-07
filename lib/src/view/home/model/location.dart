class Location {
  final double lat;
  final double lng;

  Location(this.lat, this.lng);

  Location.fromMap(Map<String, dynamic> map)
      : lat = map['lat'],
        lng = map['lng'];

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
