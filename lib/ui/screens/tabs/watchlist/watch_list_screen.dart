import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/firebase_utils.dart';
import 'package:movieapp/widgets/error_widget.dart';
import 'package:movieapp/widgets/loadeing_widget.dart';
import 'package:movieapp/widgets/movie_widget.dart';

import '../../../../data/model/movies_by_search_responses.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.all(15),
        child: Text('WatchList',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
      Expanded(
        child: StreamBuilder<QuerySnapshot<Movie>>(
          stream: FirebaseUtils.getMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            }
            if (snapshot.hasError) {
              return ErrorView(message: snapshot.error.toString());
            }

            var movies = snapshot.data?.docs.map((doc) => doc.data()).toList();

            return ListView.builder(
              itemBuilder: (context, index) {
                return MovieWidget(movie: movies![index]);
              },
              itemCount: movies?.length ?? 0,
            );
          },
        ),
      )
    ]);
  }
}
