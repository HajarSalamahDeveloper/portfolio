import 'package:get_it/get_it.dart';
import '../../features/portfolio/data/repositories/portfolio_repository.dart';
import '../../features/portfolio/presentation/cubit/portfolio_cubit.dart';
import '../../features/theme/presentation/cubit/theme_cubit.dart';

final getIt = GetIt.instance;

/// Initialize dependency injection
Future<void> initializeDependencies() async {
  // Repositories
  getIt.registerLazySingleton<PortfolioRepository>(() => PortfolioRepository());

  // Cubits
  getIt.registerFactory<PortfolioCubit>(
    () => PortfolioCubit(getIt<PortfolioRepository>()),
  );

  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
