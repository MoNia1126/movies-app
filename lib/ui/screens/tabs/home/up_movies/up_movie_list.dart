import 'package:flutter/material.dart';
import 'package:movieapp/data/repos/movies_repo/data_sources/online_data_sources.dart';
import 'package:movieapp/ui/screens/tabs/home/up_movies/build_up_movie.dart';

import '../../../../../data/model/movies_by_search_responses.dart';
import '../../../../../widgets/error_widget.dart';
import '../../../../../widgets/loadeing_widget.dart';

class UpMovieList extends StatelessWidget {
  UpMovieList({super.key});

  static late int upLength;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnlineDataSources.getUpcomingMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildMoviesList(snapshot.data!);
        } else if (snapshot.hasError) {
          return ErrorView(message: snapshot.error.toString());
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Widget buildMoviesList(List<Results> upMovie) {
    upLength = upMovie.length;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: upMovie.length,
      itemBuilder: (context, index) {
        return BuildUpMovie(resultsUp: upMovie[index]);
      },
    );
  }
}
