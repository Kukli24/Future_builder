import 'package:future_builder/models/data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Launch>> getLaunches(String query) async {
  Uri url = Uri.parse('https://api.spacexdata.com/v4/launches');
  final response = await http.get(url);
  var data = json.decode(response.body);
  List<Launch> launches = [];
  for (var launchJson in data) {
    launches.add(Launch.fromJson(launchJson));
  }
  return launches.where((lanzamiento) {
    final lanzamientoLower = lanzamiento.id.toString().toLowerCase();

    final searchLower = query.toLowerCase();

    return lanzamientoLower.contains(searchLower);
  }).toList();
}
