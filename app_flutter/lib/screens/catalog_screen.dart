import 'package:flutter/material.dart';

import '../data/sample_books.dart';
import '../models/book.dart';
import '../theme/app_theme.dart';
import '../widgets/book_details_sheet.dart';
import '../widgets/book_list_tile.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'Todos';

  final _categories = const [
    'Todos',
    'Ficção',
    'Tecnologia',
    'História',
    'Clássicos',
  ];

  List<Book> get _filteredBooks {
    final query = _searchController.text.trim().toLowerCase();

    return sampleBooks.where((book) {
      final matchesSearch = query.isEmpty ||
          book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);
      final matchesCategory = _selectedCategory == 'Todos' ||
          book.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final books = _filteredBooks;

    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
      children: [
        Text(
          'Catálogo de livros',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.deep,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Pesquise obras cadastradas na biblioteca.',
          style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'Buscar por título ou autor...',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 13),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 7),
            itemBuilder: (context, index) {
              final category = _categories[index];
              final selected = category == _selectedCategory;

              return ChoiceChip(
                label: Text(category),
                selected: selected,
                onSelected: (_) {
                  setState(() => _selectedCategory = category);
                },
                showCheckmark: false,
                selectedColor: AppColors.forest,
                backgroundColor: AppColors.card,
                side: BorderSide(
                  color: selected ? AppColors.forest : AppColors.border,
                ),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : AppColors.secondaryText,
                  fontSize: 11,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '${books.length} livro(s) encontrado(s)',
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        if (books.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: const Column(
              children: [
                Icon(Icons.menu_book_outlined, size: 34, color: AppColors.secondaryText),
                SizedBox(height: 10),
                Text('Nenhum livro encontrado.'),
                SizedBox(height: 4),
                Text(
                  'Tente outro título, autor ou categoria.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          )
        else
          ...books.map(
            (book) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: BookListTile(
                book: book,
                onTap: () => showBookDetails(context, book),
              ),
            ),
          ),
        const SizedBox(height: 12),
        const Text(
          'Os livros desta versão são exemplos fictícios para demonstrar a interface.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.secondaryText, fontSize: 9),
        ),
      ],
    );
  }
}
