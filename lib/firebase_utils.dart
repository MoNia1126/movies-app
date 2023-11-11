import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movieapp/data/model/movies_by_search_responses.dart';

class FirebaseUtils {
  static CollectionReference<Movie> getMoviesCollection() {
    return FirebaseFirestore.instance.collection('movies').withConverter<Movie>(
        fromFirestore: (snapshot, options) => Movie.fromJson(snapshot.data()!),
        toFirestore: (result, options) => result.toJson());
  }

  static Future<void> addMovie(Movie movie) {
    var collectionRef = getMoviesCollection();
    var docRef = collectionRef.doc(movie.id.toString());
    return docRef.set(movie);
  }

  static Stream<QuerySnapshot<Movie>> getMovies() {
    return getMoviesCollection().snapshots();
  }

  static Future<void> deleteMovie(Movie movie) {
    return getMoviesCollection().doc(movie.id.toString()).delete();
  }
}
