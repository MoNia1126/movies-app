import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/data/model/categoryResponse.dart';
import 'package:movieapp/ui/screens/tabs/browse/filtered_movies_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BrowseScreen> {
  List<Genres> genres = [];

  @override
  void initState() {
    super.initState();
    fetchGenres();
  }

  Future<void> fetchGenres() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=6dfe10460aba32397d0ec5fa8a3ac9d2'));
    var json = jsonDecode(response.body);
    var categoryResponse = CategoryResponse.fromJson(json);
    if (response.statusCode == 200) {
      setState(() {
        genres = categoryResponse.genres ?? [];
      });
    } else {
      print('Failed to fetch genres');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Browse Category',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xff121312),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GridView.builder(
          itemCount: genres.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            List<String> imageNames = [
              'assets/images/Action.jpeg',
              'assets/images/Adventure.jpeg',
              'assets/images/Animation.jpeg',
              'assets/images/Comedy.jpeg',
              'assets/images/Crime.jpeg',
              'assets/images/Documentary.jpeg',
              'assets/images/Drama.jpeg',
              'assets/images/Family.jpeg',
              'assets/images/Music.jpeg',
              'assets/images/History.jpeg',
              'assets/images/Horror.jpeg',
              'assets/images/Fantasy.jpeg',
              'assets/images/Mystery.jpeg',
              'assets/images/Romance.jpeg',
              'assets/images/Science Fiction.jpeg',
              'assets/images/TV Movie.jpeg',
              'assets/images/Thriller.jpeg',
              'assets/images/War.jpeg',
              'assets/images/Western.jpeg',
            ];
            return Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 4, right: 5),
              child: GridTile(
                child: InkWell(
                  onTap: () {
                    ///Click to another screen
                    Navigator.of(context).pushNamed(
                        FilteredMoviesScreen.routeName,
                        arguments: genres[index]);
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        width: 300,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(
                              imageNames[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 5,
                          bottom: 5,
                          left: 5,
                          right: 5,
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 1),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    genres[index].name ?? '',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
