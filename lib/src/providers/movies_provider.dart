import 'package:peliculas_07/src/models/actors_model.dart';
import 'package:peliculas_07/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

class MoviesProvider {
  String _apiKey = 'fc8bac745d30fd4db9a45e3b14f6d150';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _trendingPage = 0;
  bool _loading = false;

  List<Movie> _trending = new List();
  /* Stream */
  // Initialization and instance the stream
  final _trendingStreamController =
      new StreamController<List<Movie>>.broadcast();

  // Open and send the stream
  Function(List<Movie>) get trendingSink => _trendingStreamController.sink.add;

  // Recieve the stream
  Stream<List<Movie>> get trendingStream => _trendingStreamController.stream;

  // Close the stram
  void disposeStreams() {
    _trendingStreamController?.close();
  }

  Future<List<Movie>> _getResponse(Uri url) async {
    final res = await http.get(url);
    final decodedData = json.decode(res.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getInCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _getResponse(url);
  }

  Future<List<Movie>> getTrending() async {
    if (_loading) return [];
    _loading = true;
    _trendingPage++;
    final url = Uri.http(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _trendingPage.toString()
    });

    final response = await _getResponse(url);

    _trending.addAll(response);
    trendingSink(_trending);

    _loading = false;
    return response;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits',
        {'api_key': _apiKey, 'language': _language});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    return await _getResponse(url);
  }
}
