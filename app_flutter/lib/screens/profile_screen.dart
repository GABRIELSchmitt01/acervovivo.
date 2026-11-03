import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
      children: [
        Text(
          'Perfil',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.deep,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Área de identificação do usuário.',
          style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: AppColors.mint,
                child: Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.forest,
                  size: 36,
                ),
              ),
              SizedBox(height: 14),
              Text(
                'Identificação ainda não configurada',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'O login e as permissões de bibliotecário e usuário comum '
                'serão definidos antes de implementar o acesso aos dados.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
