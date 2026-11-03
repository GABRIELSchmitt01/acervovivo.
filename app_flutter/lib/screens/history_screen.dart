import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
      children: [
        Text(
          'Meu histórico',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.deep,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Acompanhe seus empréstimos.',
          style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.history_rounded,
                size: 46,
                color: AppColors.forest,
              ),
              SizedBox(height: 14),
              Text(
                'Ainda não há empréstimos registrados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Quando o controle de empréstimos for implementado e houver '
                'registros, eles aparecerão nesta área.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  height: 1.4,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
