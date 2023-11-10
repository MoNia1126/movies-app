import 'package:flutter/material.dart';
import 'package:movieapp/data/model/categoryResponse.dart';
import 'package:movieapp/data/repos/movies_repo/data_sources/online_data_sources.dart';
import 'package:movieapp/widgets/loadeing_widget.dart';
import 'package:movieapp/widgets/movie_widget.dart';

import '../../../../data/model/filteredMoviesResponse.dart';

class FilteredMoviesScreen extends StatefulWidget {
  static const String routeName = 'filteredMovies';

  const FilteredMoviesScreen({super.key});

  @override
  State<FilteredMoviesScreen> createState() => _FilteredMoviesScreenState();
}

class _FilteredMoviesScreenState extends State<FilteredMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    var genres = ModalRoute.of(context)?.settings.arguments as Genres;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 19, 18),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          genres.name ?? '',
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
      body: FutureBuilder<FilteredMoviesResponse>(
        future: OnlineDataSources.getFilteredMovies(genres.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Text(snapshot.error.toString(),
                      style: const TextStyle(color: Colors.white)),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          OnlineDataSources.getFilteredMovies(
                              genres.id.toString());
                        });
                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(253, 174, 26, 1.0),
                      )),
                      child: const Text(
                        'try again',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            );
          }
          if (snapshot.data?.success == false) {
            return Center(
              child: Column(
                children: [
                  Text(snapshot.data?.status_message ?? 'something went wrong',
                      style: const TextStyle(color: Colors.white)),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          OnlineDataSources.getFilteredMovies(
                              genres.id.toString());
                        });
                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(253, 174, 26, 1.0),
                      )),
                      child: const Text(
                        'try again',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            );
          }
          var moviesList = snapshot.data?.results;
          return ListView.builder(
            itemBuilder: (context, index) {
              return MovieWidget(movie: moviesList![index]);
            },
            itemCount: moviesList?.length ?? 0,
          );
        },
      ),
    );
  }
}
