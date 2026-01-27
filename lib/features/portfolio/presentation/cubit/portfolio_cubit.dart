import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/portfolio_repository.dart';
import 'portfolio_state.dart';

/// Cubit for managing portfolio data state
class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioRepository _repository;

  PortfolioCubit(this._repository) : super(const PortfolioInitial());

  /// Load all portfolio data
  Future<void> loadPortfolioData() async {
    try {
      emit(const PortfolioLoading());

      final data = await _repository.getAllPortfolioData();

      emit(
        PortfolioLoaded(
          profile: data['profile'],
          experiences: data['experiences'],
          education: data['education'],
          skills: data['skills'],
          projects: data['projects'],
        ),
      );
    } catch (e) {
      emit(PortfolioError('Failed to load portfolio data: ${e.toString()}'));
    }
  }

  /// Refresh portfolio data
  Future<void> refreshPortfolioData() async {
    await loadPortfolioData();
  }
}
