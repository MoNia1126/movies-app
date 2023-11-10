import 'package:flutter/material.dart';
import 'package:movieapp/data/repos/movies_repo/data_sources/online_data_sources.dart';

import '../../../../../data/model/movies_by_search_responses.dart';
import '../../../../../widgets/error_widget.dart';
import '../../../../../widgets/loadeing_widget.dart';
import 'build_movie.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnlineDataSources.getRecommendedMovies(),
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

  Widget buildMoviesList(List<Results> reMovie) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: reMovie.length,
      itemBuilder: (context, index) {
        return BuildMovie(resultsRe: reMovie[index]);
      },
    );
  }
}
