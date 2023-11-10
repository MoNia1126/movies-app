import 'package:flutter/material.dart';
import 'package:movieapp/ui/screens/details_screen/datails_screen.dart';
import 'package:movieapp/ui/screens/home_screen.dart';
import 'package:movieapp/ui/screens/tabs/browse/filtered_movies_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          DetailsScreen.routeName: (_) => DetailsScreen(),
          FilteredMoviesScreen.routeName: (_) => FilteredMoviesScreen()
        },
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
