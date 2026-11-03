import 'package:flutter/material.dart';

import '../models/book.dart';
import '../theme/app_theme.dart';
import 'book_cover.dart';

Future<void> showBookDetails(BuildContext context, Book book) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.canvas,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      final available = book.availableCopies > 0;

      return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Center(child: BookCover(book: book, width: 180, height: 120)),
              const SizedBox(height: 18),
              Text(
                book.category.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.forest,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.7,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                book.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.deep,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                book.author,
                style: const TextStyle(color: AppColors.secondaryText),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      available ? Icons.check_circle_outline : Icons.info_outline,
                      color: available ? AppColors.forest : AppColors.danger,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        available
                            ? '${book.availableCopies} de ${book.totalCopies} exemplares disponíveis'
                            : 'Nenhum exemplar disponível no momento',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Sobre o livro',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 7),
              Text(
                book.description,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fechar'),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Informações de demonstração. O cadastro real será carregado '
                'quando a persistência dos dados for implementada.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
