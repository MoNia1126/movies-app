import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movieapp/data/model/details_movie_responses.dart';
import 'package:movieapp/data/model/filteredMoviesResponse.dart';
import 'package:movieapp/data/model/movies_by_search_responses.dart';
import 'package:movieapp/data/model/popular_movies_responses.dart';
import 'package:movieapp/data/model/recommended_movies_responses.dart';
import 'package:movieapp/data/model/similar_movies_responses.dart';
import 'package:movieapp/data/model/upcoming_movies_responses.dart';

class OnlineDataSources {
  static const String urlBase = "api.themoviedb.org";
  static const String simiBaseUrl = "api.themoviedb.org/3/movie/";
  static const String apiKey = "6dfe10460aba32397d0ec5fa8a3ac9d2";
  static const String popularMoviesEndPoint = "/3/movie/popular";
  static const String upcomingMoviesEndPoint = "/3/movie/upcoming";
  static const String recommendedMoviesEndPoint = "/3/movie/top_rated";
  static const String detailsScreenEndPoint = "/3/movie/";
  static const String similarMoviesEndPoint = "/similar";
  static const String searchEndPoint = "/3/search/movie";
  static const String moviesList = "/3/genre/movie/list";
  static const String filteredMoviesEndPoint = "/3/discover/movie";

  static const Map<String, String> headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZGZlMTA0NjBhYmEzMjM5N2QwZWM1ZmE4YTNhYzlkMiIsInN1YiI6IjY1NDk0ZDQwNDM0OTRmMDBlNDk0NGY1OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GTWqqH-EdzKsB4mSZX058fdch5HdebACBUHfo7BsHaw',
    'accept': 'application/json',
  };

  Future<PopularMoviesResponses> getPopularMovies() async {
    Uri url = Uri.https(urlBase, popularMoviesEndPoint);
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    PopularMoviesResponses popularMoviesResponses =
        PopularMoviesResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        popularMoviesResponses.results!.isNotEmpty == true) {
      return popularMoviesResponses;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<List<Results>> getUpcomingMovies() async {
    Uri url = Uri.https(urlBase, upcomingMoviesEndPoint);
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    UpcomingMoviesResponses upcomingMoviesResponses =
        UpcomingMoviesResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        upcomingMoviesResponses.results!.isNotEmpty == true) {
      return upcomingMoviesResponses.results!;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<List<Results>> getRecommendedMovies() async {
    Uri url = Uri.https(urlBase, recommendedMoviesEndPoint);
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    RecommendedMoviesResponses recommendedMoviesResponses =
        RecommendedMoviesResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        recommendedMoviesResponses.results!.isNotEmpty == true) {
      return recommendedMoviesResponses.results!;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<DetailsMovieResponses> getDetailsMovies(String id) async {
    Uri url = Uri.parse("https://$urlBase$detailsScreenEndPoint$id");
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    DetailsMovieResponses detailsMovieResponses =
        DetailsMovieResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        id.isNotEmpty == true) {
      return detailsMovieResponses;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<List<Results>> getSimilarMovies(String id) async {
    Uri url = Uri.parse("https://$simiBaseUrl$id$similarMoviesEndPoint");
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    SimilarMoviesResponses similarMoviesResponses =
        SimilarMoviesResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        id.isNotEmpty) {
      return similarMoviesResponses.results!;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<List<Results>> getMoviesBySearch(String q) async {
    Uri url = Uri.https(urlBase, searchEndPoint, {"query": q});
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    MoviesBySearchResponses moviesBySearchResponses =
        MoviesBySearchResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        q.isNotEmpty) {
      return moviesBySearchResponses.results!;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<FilteredMoviesResponse> getFilteredMovies(
      String genresId) async {
    Uri url =
        Uri.https(urlBase, filteredMoviesEndPoint, {"with_genres": genresId});

    var response = await http.get(url, headers: headers);
    var json = jsonDecode(response.body);
    var filteredMoviesResponse = FilteredMoviesResponse.fromJson(json);
    return filteredMoviesResponse;
  }
}
