class Movie {
  final String title;
  final String imageUrl;
  final String description;
  final String category;
  final String imbdScore;
  final String genre;
  final String runtime;
  final String storyBy;
  final String releaseDate;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.imbdScore,
    required this.genre,
    required this.runtime,
    required this.storyBy,
    required this.releaseDate,
  });

  factory Movie.fromMap(Map<String, dynamic> data) {
    return Movie(
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      imbdScore: data['imbdScore'] ?? '',
      genre: data['genre'] ?? '',
      runtime: data['runtime'] ?? '',
      storyBy: data['storyBy'] ?? '',
      releaseDate: data['releaseDate'] ?? '',
    );
  }
}
