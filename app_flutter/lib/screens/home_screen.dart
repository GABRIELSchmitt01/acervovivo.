import 'package:flutter/material.dart';

import '../data/sample_books.dart';
import '../models/book.dart';
import '../theme/app_theme.dart';
import '../widgets/book_card.dart';
import '../widgets/book_details_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.onOpenCatalog,
    required this.onOpenHistory,
    super.key,
  });

  final VoidCallback onOpenCatalog;
  final VoidCallback onOpenHistory;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Todos';

  final _categories = const [
    'Todos',
    'Ficção',
    'Tecnologia',
    'História',
    'Clássicos',
  ];

  List<Book> get _featuredBooks {
    final books = sampleBooks.where((book) {
      return _selectedCategory == 'Todos' ||
          book.category == _selectedCategory;
    }).toList();

    return books.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
      children: [
        _buildHeader(context),
        const SizedBox(height: 28),
        const Text(
          'BIBLIOTECA AO SEU ALCANCE',
          style: TextStyle(
            color: AppColors.forest,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          'Sua próxima leitura\ncomeça aqui.',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.deep,
                fontWeight: FontWeight.w800,
                height: 1.08,
              ),
        ),
        const SizedBox(height: 9),
        const Text(
          'Encontre histórias, descubra autores e explore o acervo.',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: widget.onOpenCatalog,
          borderRadius: BorderRadius.circular(15),
          child: IgnorePointer(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar por título, autor...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
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
                labelStyle: TextStyle(
                  color: selected ? Colors.white : AppColors.secondaryText,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                selectedColor: AppColors.forest,
                backgroundColor: AppColors.card,
                side: BorderSide(
                  color: selected ? AppColors.forest : AppColors.border,
                ),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 7),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Text(
                'Destaques do acervo',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            TextButton(
              onPressed: widget.onOpenCatalog,
              child: const Text('Ver catálogo'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 244,
          child: _featuredBooks.isEmpty
              ? const Center(child: Text('Nenhum livro nesta categoria.'))
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _featuredBooks.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final book = _featuredBooks[index];
                    return BookCard(
                      book: book,
                      onTap: () => showBookDetails(context, book),
                    );
                  },
                ),
        ),
        const SizedBox(height: 22),
        InkWell(
          onTap: widget.onOpenHistory,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.card,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.mint,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.history_rounded,
                    color: AppColors.forest,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seus empréstimos',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Acompanhe os livros com você.',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.forest,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Dados de demonstração: ainda não há conexão com banco de dados.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.forest,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AcervoVivo',
                style: TextStyle(
                  color: AppColors.deep,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'SEU UNIVERSO DE LEITURAS',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 8,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'O acesso ao perfil será definido na próxima etapa.',
                ),
              ),
            );
          },
          style: IconButton.styleFrom(
            backgroundColor: AppColors.mint,
            foregroundColor: AppColors.forest,
          ),
          icon: const Icon(Icons.person_outline_rounded),
        ),
      ],
    );
  }
}
