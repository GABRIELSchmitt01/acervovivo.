import '../models/book.dart';

/// Dados fictícios usados apenas para demonstrar a interface nesta primeira
/// etapa. Eles serão substituídos pelos registros persistidos quando o banco
/// de dados e a arquitetura de sincronização forem definidos.
const sampleBooks = <Book>[
  Book(
    id: 'book-001',
    title: 'O Pequeno Príncipe',
    author: 'Antoine de Saint-Exupéry',
    category: 'Ficção',
    description:
        'Uma história sobre amizade, afeto e o olhar curioso de uma criança '
        'sobre o mundo.',
    totalCopies: 5,
    availableCopies: 3,
  ),
  Book(
    id: 'book-002',
    title: 'O Hobbit',
    author: 'J. R. R. Tolkien',
    category: 'Ficção',
    description:
        'Uma aventura que acompanha Bilbo Bolseiro em uma jornada inesperada.',
    totalCopies: 4,
    availableCopies: 1,
  ),
  Book(
    id: 'book-003',
    title: 'Dom Casmurro',
    author: 'Machado de Assis',
    category: 'Clássicos',
    description:
        'Romance brasileiro narrado por Bento Santiago, conhecido como Dom '
        'Casmurro.',
    totalCopies: 3,
    availableCopies: 0,
  ),
  Book(
    id: 'book-004',
    title: 'Código Limpo',
    author: 'Robert C. Martin',
    category: 'Tecnologia',
    description:
        'Práticas e princípios para escrever código mais legível e fácil de '
        'manter.',
    totalCopies: 2,
    availableCopies: 2,
  ),
  Book(
    id: 'book-005',
    title: 'Uma Breve História do Tempo',
    author: 'Stephen Hawking',
    category: 'História',
    description:
        'Uma introdução a perguntas fundamentais sobre o universo e o tempo.',
    totalCopies: 2,
    availableCopies: 1,
  ),
];
