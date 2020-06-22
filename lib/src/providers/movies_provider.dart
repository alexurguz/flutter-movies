import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider{

  String _apiKey = 'api key https://www.themoviedb.org';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularPage = 0;
  bool _loading = false;
  List<Movie> _popularMovies = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;
  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams(){
    _popularStreamController?.close();
  }

  Future<List<Movie>>_processResponse(Uri url) async {

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  Future<List<Movie>>getMoviesNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key': _apiKey,
      'language': _language
    });

    return await _processResponse(url);
  }

  Future<List<Movie>>getPopularMovies() async {

    if ( _loading ) return [];

    _loading = true;
    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final resp = await _processResponse(url);
    _popularMovies.addAll(resp);
    popularSink(_popularMovies);

    _loading = false;
    return resp;
  }

    Future<List<Movie>> searchMovie( String query ) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : query
    });

    return await _processResponse(url);

  }
}
