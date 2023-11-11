import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/data/model/movies_by_search_responses.dart';
import 'package:movieapp/ui/screens/details_screen/datails_screen.dart';
import 'package:movieapp/widgets/loadeing_widget.dart';

class MovieWidget extends StatelessWidget {
  Movie movie;

  MovieWidget({super.key, required this.movie});

  String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, DetailsScreen.routeName,
                  arguments: movie.id.toString());
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: "$baseUrl${movie.posterPath}",
                    height: MediaQuery.of(context).size.height * .20,
                    width: MediaQuery.of(context).size.width * .35,
                    placeholder: (context, url) {
                      return const LoadingWidget();
                    },
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) {
                      return const Center(
                        child: Icon(
                          Icons.error,
                          color: Color.fromARGB(255, 253, 178, 38),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .09,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(movie.title ?? "",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                softWrap: false,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${DateTime.tryParse(movie.releaseDate!)?.year ?? "".toString()}",
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white54,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color.fromARGB(255, 251, 174, 31),
                              size: 16),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            movie.voteAverage!.toStringAsFixed(1),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            color: Colors.white,
            indent: 6,
            endIndent: 6,
          )
        ],
      ),
    );
  }
}
