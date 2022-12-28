import 'dart:convert';
import 'package:http/http.dart' as http;

class TestService{
  Future<List> fetchData(String text) async {
    var data = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    return jsonDecode(data.body);
  }
}