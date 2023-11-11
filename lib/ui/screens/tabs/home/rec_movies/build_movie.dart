import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/ui/screens/details_screen/datails_screen.dart';

import '../../../../../data/model/movies_by_search_responses.dart';
import '../../../../../firebase_utils.dart';
import '../../../../../widgets/loadeing_widget.dart';

class BuildMovie extends StatefulWidget {
  Movie resultsRe;

  BuildMovie({required this.resultsRe});

  @override
  State<BuildMovie> createState() => _BuildMovieState();
}

class _BuildMovieState extends State<BuildMovie> {
  bool isAdded = false;

  String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName,
            arguments: widget.resultsRe.id.toString());
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
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(6),
                        topLeft: Radius.circular(6)),
                    child: Stack(children: [
                      CachedNetworkImage(
                        imageUrl: "$baseUrl${widget.resultsRe.posterPath}",
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
                              FirebaseUtils.addMovie(widget.resultsRe);
                            } else {
                              FirebaseUtils.deleteMovie(widget.resultsRe);
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
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
              child: Container(
                padding: const EdgeInsets.all(4),
                width: MediaQuery.of(context).size.width * .28,
                height: MediaQuery.of(context).size.height * .067,
                color: const Color.fromARGB(255, 52, 53, 52),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Image(
                            image: AssetImage('assets/images/Group 16.png')),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.resultsRe.voteAverage!.toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                        width: 200,
                        child: Text(widget.resultsRe.title ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false)),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          "${DateTime.tryParse(widget.resultsRe.releaseDate!)?.year ?? "".toString()}",
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.resultsRe.adult! ? "R" : "PG-3",
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
