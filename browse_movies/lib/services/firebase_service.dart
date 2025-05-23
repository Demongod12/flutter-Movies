import 'package:browse_movies/components/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final CollectionReference movieCollection = FirebaseFirestore.instance
      .collection('movies');

  Future<List<Movie>> fetchMoviesByCategory(String category) async {
    final snapshot =
        await movieCollection.where('category', isEqualTo: category).get();
    return snapshot.docs
        .map((doc) => Movie.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
