import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'features/portfolio/presentation/cubit/portfolio_cubit.dart';
import 'features/theme/presentation/cubit/theme_cubit.dart';

/// Global MultiBlocProvider setup for all feature cubits
class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => getIt<ThemeCubit>()),
        BlocProvider<PortfolioCubit>(
          create: (context) => getIt<PortfolioCubit>()..loadPortfolioData(),
        ),
      ],
      child: child,
    );
  }
}
