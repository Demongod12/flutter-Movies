// main_home_screen.dart
import 'package:browse_movies/components/movie_model.dart';
import 'package:browse_movies/screens/movie_detail_screen.dart';
import 'package:browse_movies/services/firebase_service.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final firebaseService = FirebaseService();

  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = firebaseService.fetchMoviesByCategory('popular');
    topRatedMovies = firebaseService.fetchMoviesByCategory('top_rated');
    upcomingMovies = firebaseService.fetchMoviesByCategory('upcoming');
  }

  Widget buildMovieSection(String title, Future<List<Movie>> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        FutureBuilder<List<Movie>>(
          future: movies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return Text(
                'Error loading movies',
                style: TextStyle(color: Colors.white),
              );
            }
            return SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final movie = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailScreen(movie: movie),
                        ),
                      );
                    },
                    child: Container(
                      width: 120,
                      margin: EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              movie.imageUrl,
                              height: 150,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            movie.title,
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2A2A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildMovieSection('popular', popularMovies),
              SizedBox(height: 30),
              buildMovieSection('Top Rated', topRatedMovies),
              SizedBox(height: 30),
              buildMovieSection('Upcoming', upcomingMovies),
            ],
          ),
        ),
      ),
    );
  }
}
