import 'package:flutter/material.dart';

import '../models/book.dart';
import '../theme/app_theme.dart';
import 'book_cover.dart';

class BookListTile extends StatelessWidget {
  const BookListTile({
    required this.book,
    required this.onTap,
    super.key,
  });

  final Book book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final available = book.availableCopies > 0;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              BookCover(book: book, width: 58, height: 72),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
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
                    const SizedBox(height: 7),
                    Text(
                      available
                          ? '${book.availableCopies} de ${book.totalCopies} exemplares disponíveis'
                          : 'Nenhum exemplar disponível',
                      style: TextStyle(
                        color: available
                            ? AppColors.forest
                            : AppColors.danger,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.secondaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
