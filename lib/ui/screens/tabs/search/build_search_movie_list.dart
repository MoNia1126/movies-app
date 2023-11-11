import 'package:flutter/material.dart';
import 'package:movieapp/data/model/movies_by_search_responses.dart';

import '../../../../data/repos/movies_repo/data_sources/online_data_sources.dart';
import '../../../../widgets/movie_widget.dart';

class BuildSearchMovieList extends StatelessWidget {
  final String q;

  const BuildSearchMovieList({super.key, required this.q});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnlineDataSources.getMoviesBySearch(q),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildMovieList(snapshot.data!);
        } else {
          return const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage(
                      "assets/images/Icon material-local-movies.png")),
              SizedBox(
                height: 8,
              ),
              Text(
                "No movies found",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ));
        }
      },
    );
  }

  Widget buildMovieList(List<Movie> resultSear) {
    return ListView.builder(
      itemCount: resultSear.length,
      itemBuilder: (context, index) {
        return MovieWidget(movie: resultSear[index]);
      },
    );
  }
}
