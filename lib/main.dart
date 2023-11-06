import 'package:flutter/material.dart';
import 'package:movieapp/ui/screens/details_screen/datails_screen.dart';
import 'package:movieapp/ui/screens/home_screen.dart';
import 'package:movieapp/ui/screens/tabs/browse/browse_screen.dart';
import 'package:movieapp/ui/screens/tabs/home/home.dart';
import 'package:movieapp/ui/screens/tabs/search/search_screen.dart';
import 'package:movieapp/ui/screens/tabs/watchlist/watch_list_screen.dart';

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
          Home.routeName: (_) => Home(),
          BrowseScreen.routeName: (_) => const BrowseScreen(),
          SearchScreen.routeName: (_) => SearchScreen(),
          WatchListScreen.routeName: (_) => const WatchListScreen(),
          DetailsScreen.routeName: (_) => DetailsScreen(),
        },
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
