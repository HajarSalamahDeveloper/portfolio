import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../features/theme/presentation/cubit/theme_cubit.dart';

/// Floating navigation bar for section jumping
class FloatingNavBar extends StatelessWidget {
  final ScrollController scrollController;

  const FloatingNavBar({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard.withOpacity(0.9),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: AppColors.accentCyan.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo/Name
            Text(
              'HS',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.accentCyan,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 24),
            // Theme toggle
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(
                    state.themeMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: AppColors.accentCyan,
                  ),
                  onPressed: () {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                  tooltip: 'Toggle Theme',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
