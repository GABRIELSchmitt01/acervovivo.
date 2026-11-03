class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.totalCopies,
    required this.availableCopies,
  });

  final String id;
  final String title;
  final String author;
  final String category;
  final String description;
  final int totalCopies;
  final int availableCopies;
}
