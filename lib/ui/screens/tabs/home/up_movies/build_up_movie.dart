import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../data/model/movies_by_search_responses.dart';
import '../../../../../firebase_utils.dart';
import '../../../../../widgets/loadeing_widget.dart';
import '../../../details_screen/datails_screen.dart';

class BuildUpMovie extends StatefulWidget {
  Movie resultsUp;

  BuildUpMovie({super.key, required this.resultsUp});

  @override
  State<BuildUpMovie> createState() => _BuildUpMovieState();
}

class _BuildUpMovieState extends State<BuildUpMovie> {
  bool isAdded = false;

  String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName,
            arguments: widget.resultsUp.id.toString());
      },
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Stack(children: [
                      CachedNetworkImage(
                        imageUrl: "$baseUrl${widget.resultsUp.posterPath}",
                        height: MediaQuery.of(context).size.height * .19,
                        width: MediaQuery.of(context).size.width * .28,
                        fit: BoxFit.fill,
                        placeholder: (_, __) =>
                            const Center(child: LoadingWidget()),
                        errorWidget: (_, __, ___) => const Icon(
                          Icons.error,
                          color: Color.fromRGBO(253, 174, 26, 1.0),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            isAdded = !isAdded;
                            if (isAdded) {
                              FirebaseUtils.addMovie(widget.resultsUp);
                            } else {
                              FirebaseUtils.deleteMovie(widget.resultsUp);
                            }
                            setState(() {});
                          },
                          child: Image(
                              image: AssetImage(isAdded
                                  ? 'assets/images/done_icon.png'
                                  : 'assets/images/bookmark.png'))),
                    ])),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
