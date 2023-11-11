import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/splash_screen.dart';
import 'package:movieapp/ui/screens/details_screen/datails_screen.dart';
import 'package:movieapp/ui/screens/home_screen.dart';
import 'package:movieapp/ui/screens/tabs/browse/filtered_movies_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          SplashScreen.routeName: (_) => const SplashScreen(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          DetailsScreen.routeName: (_) => DetailsScreen(),
          FilteredMoviesScreen.routeName: (_) => const FilteredMoviesScreen()
        },
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
