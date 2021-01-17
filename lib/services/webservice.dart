import 'dart:convert';
import 'package:flutter_mvvm/models/update.dart';
import 'package:flutter_mvvm/models/photo.dart';
import 'package:http/http.dart' as http;

class Webservice {
  Future<List<Update>> fetchUpdates() async {
    final url = "http://evertschavez.com/fluttermvvm/updates.json";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable json = body["data"]["updates"];
      return json.map((update) => Update.fromJson(update)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  Future<List<Photo>> fetchPhotos() async {
    final url = "https://jsonplaceholder.typicode.com/photos";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable json = body;
      return json.map((photo) => Photo.fromJson(photo)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
