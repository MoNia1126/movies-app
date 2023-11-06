import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movieapp/data/model/details_movie_responses.dart';
import 'package:movieapp/data/model/movies_by_search_responses.dart';
import 'package:movieapp/data/model/popular_movies_responses.dart';
import 'package:movieapp/data/model/recommended_movies_responses.dart';
import 'package:movieapp/data/model/similar_movies_responses.dart';
import 'package:movieapp/data/model/upcoming_movies_responses.dart';

class OnlineDataSources {
  static const String urlBase = "api.themoviedb.org";
  static const String simiBaseUrl = "api.themoviedb.org/3/movie/";
  static const String apiKey = "8bcaebf0d1310c08bc2f916753bff65e";
  static const String popularMoviesEndPoint = "/3/movie/popular";
  static const String upcomingMoviesEndPoint = "/3/movie/upcoming";
  static const String recommendedMoviesEndPoint = "/3/movie/top_rated";
  static const String detailsScreenEndPoint = "/3/movie/";
  static const String similarMoviesEndPoint = "/similar";
  static const String searchEndPoint = "/3/search/movie";

  static const Map<String, String> headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YmNhZWJmMGQxMzEwYzA4YmMyZjkxNjc1M2JmZjY1ZSIsInN1YiI6IjY1M2ZlYjBlZTg5NGE2MDBmZjE4MTFhMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jotI1JAx-7oGhzLmK4xguL84xkcpLxfJ4dhKyHLJfT4',
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

  static Future<List<ResultsUp>> getUpcomingMovies() async {
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

  static Future<List<ResultsRec>> getRecommendedMovies() async {
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

  static Future<List<ResultsSim>> getSimilarMovies(String id) async {
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
}
