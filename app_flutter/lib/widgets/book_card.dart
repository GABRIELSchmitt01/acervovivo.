import 'package:flutter/material.dart';

import '../models/book.dart';
import '../theme/app_theme.dart';
import 'book_cover.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    required this.book,
    required this.onTap,
    super.key,
  });

  final Book book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final available = book.availableCopies > 0;

    return SizedBox(
      width: 168,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookCover(book: book, width: double.infinity, height: 90),
                const SizedBox(height: 10),
                Text(
                  book.category.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.forest,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.7,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  book.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: available ? AppColors.forest : AppColors.danger,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        available
                            ? '${book.availableCopies} disponíveis'
                            : 'Indisponível',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: available
                              ? AppColors.forest
                              : AppColors.danger,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
