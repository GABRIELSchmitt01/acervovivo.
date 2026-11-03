import 'package:flutter/material.dart';

import '../models/book.dart';
import '../theme/app_theme.dart';

class BookCover extends StatelessWidget {
  const BookCover({
    required this.book,
    this.width = 142,
    this.height = 92,
    super.key,
  });

  final Book book;
  final double width;
  final double height;

  Color get _background {
    switch (book.category) {
      case 'Tecnologia':
        return const Color(0xFFE7E9F5);
      case 'História':
        return AppColors.warmCover;
      case 'Clássicos':
        return const Color(0xFFEDE8DD);
      default:
        return AppColors.mint;
    }
  }

  Color get _accent {
    switch (book.category) {
      case 'Tecnologia':
        return const Color(0xFF596A9A);
      case 'História':
        return AppColors.apricot;
      case 'Clássicos':
        return const Color(0xFF8B7760);
      default:
        return AppColors.apricot;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 9,
            child: Text(
              'ACERVOVIVO',
              style: TextStyle(
                color: AppColors.deep,
                fontSize: width < 70 ? 5 : 8,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Positioned(
            left: width * 0.12,
            bottom: height * 0.16,
            child: Container(
              width: height * 0.48,
              height: height * 0.48,
              decoration: BoxDecoration(
                color: _accent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: width * 0.15,
            top: height * 0.2,
            child: Container(
              width: width * 0.18,
              height: height * 0.62,
              decoration: BoxDecoration(
                color: AppColors.forest,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned(
            left: width * 0.12,
            bottom: 8,
            child: Container(
              width: width * 0.42,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
