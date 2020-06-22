import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:movies/src/models/actor_model.dart';

class ActorsProvider{

  String _apiKey = 'd617577676070b32f770f3227974c5bc';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Actor>>_processResponse(Uri url) async {

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodeData['cast']);

    return cast.actors;
  }

  Future<List<Actor>>getCastMovie( String movieId ) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits',{
      'api_key': _apiKey,
      'language': _language
    });

    return await _processResponse(url);
  }
}