import 'package:browse_movies/components/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2A2A2A),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(movie.title, style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .collection('favourites')
                    .add({
                      'title': movie.title,
                      'genres': movie.genre,
                      'imageUrl': movie.imageUrl,
                    });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Added to Favourites")));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("You must be signed in to add favourites. "),
                  ),
                );
              }
            },
            icon: Icon(Icons.favorite_border, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                movie.imageUrl,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Released Date: ${movie.releaseDate}",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Running time: ${movie.runtime}",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Story by: ${movie.storyBy}",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "IMBD: ${movie.imbdScore}",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.description,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0D3376),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.play_circle_fill, color: Colors.white),
              label: Text("Watch now", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
